table 50100 "CSD Seminar Setup"
// CSD1.00, 05-05-2021, RASEG
{
    DataClassification = CustomerContent;
    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Key';
        }

        field(20; "Seminar Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Seminar Nos.';
            TableRelation = "No. Series";
        }

        field(30; "Seminar Registration Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Seminar Registration Nos.';
            TableRelation = "No. Series";
        }

        field(40; "Posted Seminar Reg. Nos."; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Posted Seminar Reg. Nos.';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}