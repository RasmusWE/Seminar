pageextension 50100 "CSD Resource Card" extends "Resource Card"
// CSD1.00, 05-05-2021, RASEG
{
    layout
    {
        addlast("General")
        {
            field("CSD Resource Type"; Rec."CSD Resource Type")
            {
                ApplicationArea = All;
            }
            field("CSD Quantity per Day"; Rec."CSD Quantity per Day")
            {
                ApplicationArea = All;
            }
        }

        addafter("Personal Data")
        {
            group("CSD Room")
            {
                Caption = 'Room';
                Visible = ShowRoom;
                field("CSD Maximum Participants"; Rec."CSD Maximum Participants")
                {
                    ApplicationArea = All;
                }
            }
        }

        modify(Type)
        {
            trigger OnAfterValidate()
            var
                l_ResourceCard: page 76;
            begin
                ShowRoom := (Rec.Type = Rec.Type::Machine);
                CurrPage.Update(true);
            end;
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowRoom := (Rec.Type = Rec.Type::Machine);
        CurrPage.Update(false);
    end;

    var
        [InDataSet]
        ShowRoom: Boolean;
}