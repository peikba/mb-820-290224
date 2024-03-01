page 50100 "CSD Subscription Card"
{
    Caption = 'Subscription Card';
    PageType = Card;
    SourceTable = "CSD Subscription";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Item Number"; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Item Number';

                }
                field("Invoicing Schedule"; Rec."Invoicing Schedule")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoicing Schedule';

                }
                field("Invoicing Frequence"; Rec."Invoicing Frequence")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoicing Frequence';

                }
                field("Invoicing Price"; Rec."Invoicing Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoicing Price';

                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Call Hello World")
            {
                Caption = 'Call Hello World';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Message('Hello World');
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref("Call Hello World_Promoted"; "Call Hello World")
                {
                }
            }
        }
    }
}