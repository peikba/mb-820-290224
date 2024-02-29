page 50102 "CSD Customer Subscriptions"
{
    Caption = 'Customer Subscriptions';
    PageType = List;
    SourceTable = "CSD Customer Subscription";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Customer No.';
                    Visible = ShowCustomerNo;
                }
                field("Subscription Code"; Rec."Subscription Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Subscription Code';
                    ShowMandatory = CodeFieldMandatory;

                    trigger OnValidate()
                    begin
                        if Rec."Subscription Code" <> '' then begin
                            CodeFieldMandatory := false;
                            FieldMandatory := true;
                        end;
                    end;

                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item No.';
                    Visible = ShowItemNo;
                    ShowMandatory = FieldMandatory;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start Date';
                    ShowMandatory = FieldMandatory;
                }
                field("Last Invoice Date"; Rec."Last Invoice Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Last Invoice Date';
                }
                field("Next Invoice Date"; Rec."Next Invoice Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Next Invoice Date';
                }
                field("Cancelled Date"; Rec."Cancelled Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cancelled Date';
                }
                field("Active"; Rec."Active")
                {
                    ApplicationArea = All;
                    ToolTip = 'Active';
                }
                field("Invoicing Price"; Rec."Invoicing Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoicing Price';
                }
            }
        }
    }
    var
        ShowCustomerNo: Boolean;
        ShowItemNo: Boolean;
        CodeFieldMandatory: Boolean;
        FieldMandatory: Boolean;

    trigger OnOpenPage()
    var
        CaptionLbl: Label 'Customer Subscriptions for %1', Comment = '%1 = Caption for the page';
    begin
        ShowCustomerNo := (Rec.GetFilter("Customer No.") = '');
        ShowItemNo := (Rec.GetFilter("Item No.") = '');
        if not ShowCustomerNo then
            CurrPage.Caption := StrSubstNo(CaptionLbl, Rec."Customer No.");
        CodeFieldMandatory := true;
    end;
}