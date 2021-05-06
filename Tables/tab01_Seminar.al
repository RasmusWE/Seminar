table 50101 "CSD Seminar"
// CSD1.00, 05-05-2021, RASEG
{
    DataClassification = CustomerContent;
    fields
    {

        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = AccountData;

            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    g_SeminarSetup.GET;
                    g_NoSeriesMgt.TestManual(g_SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(20; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = AccountData;

            trigger OnValidate();
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or ("Search Name" = '') then
                    "Search Name" := Name;
            end;

        }
        field(30; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;
            DataClassification = AccountData;
        }
        field(40; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = AccountData;
        }

        field(50; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = AccountData;
        }
        field(60; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
            DataClassification = AccountData;
        }
        field(70; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = AccountData;
        }
        field(80; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            DataClassification = AccountData;
        }
        field(90; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line" where("Table Name" = filter("CSD Seminar"), "No." = Field("No.")));
        }


        field(100; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 1;
            DataClassification = AccountData;
        }
        field(110; "Gen. Prod. Posting Group"; code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = AccountData;

            trigger OnValidate();
            begin
                if (xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group") then begin
                    if g_GenProdPostingGroup.ValidateVatProdPostingGroup(g_GenProdPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group", g_GenProdPostingGroup."Def. VAT Prod. Posting Group");
                end;
            end;
        }
        field(120; "VAT Prod. Posting Group"; code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = AccountData;
        }
        field(130; "No. Series"; Code[10])
        {
            Editable = false;
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = AccountData;
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert();
    begin
        if "No." = '' then begin
            g_SeminarSetup.GET;
            g_SeminarSetup.TestField("Seminar Nos.");
            g_NoSeriesMgt.InitSeries(g_SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Last Date Modified" := TODAY;
    end;

    trigger OnModify();
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnRename();
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    begin
        g_CommentLine.Reset();
        g_CommentLine.SetRange("Table Name", g_CommentLine."Table Name"::"CSD Seminar");
        g_CommentLine.SetRange("No.", "No.");
        g_CommentLine.DeleteAll();
    end;

    var
        g_SeminarSetup: Record "CSD Seminar Setup";
        g_CommentLine: Record "Comment Line";
        g_Seminar: Record "CSD Seminar";
        g_GenProdPostingGroup: Record "Gen. Product Posting Group";
        g_NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure AssistEdit(): Boolean;
    begin
        with g_Seminar do begin
            g_Seminar := Rec;
            g_SeminarSetup.get;
            g_SeminarSetup.TestField("Seminar Nos.");
            if g_NoSeriesMgt.SelectSeries(g_SeminarSetup."Seminar Nos.", xRec."No. Series", "No. Series") then begin
                g_NoSeriesMgt.SetSeries("No.");
                Rec := g_Seminar;
                exit(true);
            end;
        end;
    end;

}