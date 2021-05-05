tableextension 50100 "CSD Resource Type" extends Resource
// CSD1.00, 05-05-2021, RASEG
{
    fields
    {
        field(50101; "CSD Resource Type"; Option)
        {
            Caption = 'Resource Type';
            DataClassification = CustomerContent;
            OptionMembers = "Internal","External";
        }

        field(50102; "CSD Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = CustomerContent;
        }

        field(50103; "CSD Quantity per Day"; Decimal)
        {
            Caption = 'Quantity per Day';
            DataClassification = CustomerContent;
        }

        modify("Profit %")
        {
            trigger onAfterValidate()
            begin
                TestField("Unit Cost");
            end;
        }
    }
}