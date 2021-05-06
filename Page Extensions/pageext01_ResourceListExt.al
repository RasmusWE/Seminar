pageextension 50101 MyExtension extends "Resource List"
// CSD1.00, 05-05-2021, RASEG
{
    layout
    {
        addafter(Type)
        {
            field("CSD Resource Type"; Rec."CSD Resource Type")
            {
                ApplicationArea = All;
            }
            field("CSD Maximum Participants"; Rec."CSD Maximum Participants")
            {
                ApplicationArea = All;
                Visible = ShowMaxField;
            }
        }

        modify(Type)
        {
            Visible = ShowType;
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.GetFilter("Type") = '' then
            ShowType := TRUE;
        if Rec.GetFilter("Type") = format(Rec.Type::Machine) then
            ShowMaxField := TRUE;
    end;

    var
        [InDataSet]
        ShowMaxField: Boolean;
        [InDataSet]
        ShowType: Boolean;
}