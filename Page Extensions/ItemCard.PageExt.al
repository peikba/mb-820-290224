pageextension 50103 "CSD Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("CSD Subscription Item"; Rec."CSD Subscription Item")
            {
                ApplicationArea = All;
                ToolTip = 'CSD Subscription Item';
            }
        }
        addfirst(factboxes)
        {
            part("CSD Subscription FactBox"; "CSD Subscription FactBox")
            {
                SubPageLink = "Item No." = field("No.");
            }
        }
    }

    actions
    {
        addfirst(processing)
        {
            action(Subscriptions)
            {
                ApplicationArea = All;
                Caption = '&Subscriptions';
                Image = InsuranceRegisters;
                RunObject = page "CSD Customer Subscriptions";
                RunPageLink = "Item No." = field("No.");
                ToolTip = 'Subscriptions';
            }
        }
        addlast(Category_Process)
        {
            actionref(Subscriptions_Promoted; Subscriptions)
            {
            }
        }
    }
}