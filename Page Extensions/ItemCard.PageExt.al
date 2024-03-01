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
            action("Download Image")
            {
                ApplicationArea = All;
                Caption = 'Download Image';
                Image = Download;
                trigger OnAction()
                var
                    InStr: InStream;
                    Response: HttpResponseMessage;
                    Client: HttpClient;
                    Url: Label 'https://www.sefiles.net/images/library/large/trek-wahoo-26-345352-3363194-1.png';
                begin
                    if not Client.Get(Url, Response) then
                        Error('%1', Response.ReasonPhrase);
                    Response.Content.ReadAs(InStr);
                    Rec.Picture.ImportStream(InStr, '');
                    CurrPage.Update(true);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref(Subscriptions_Promoted; Subscriptions)
            {
            }
            actionref(Download_Image; "Download Image")
            {

            }
        }
    }


    protected procedure MyProcedure()
    var
        myInt: Integer;
    begin
        if IsNonInventoriable then
            IsNonInventoriable := false;
    end;
}