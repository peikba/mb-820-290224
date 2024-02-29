page 50101 "CSD Subscription List"
{
    Caption = 'Subscriptions';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Subscription";
    Editable = false;
    CardPageId = "CSD Subscription Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Item Number';
                }
                field("Invoicing Schedule"; Rec."Invoicing Schedule")
                {
                    ToolTip = 'Invoicing Schedule';
                }
                field("Invoicing Frequence"; Rec."Invoicing Frequence")
                {
                    ToolTip = 'Invoicing Frequence';
                }
                field("Invoicing Price"; Rec."Invoicing Price")
                {
                    ToolTip = 'Invoicing Price';
                }
            }
        }
    }
}