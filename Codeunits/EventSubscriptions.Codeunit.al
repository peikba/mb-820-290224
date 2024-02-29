codeunit 50100 "CSD Event Subscriptions"
{
    Subtype = Normal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean; PreviewMode: Boolean);
    var
        SalesInvLine: Record "Sales Invoice Line";
        CustomerSubscription: Record "CSD Customer Subscription";
        SubScription: Record "CSD Subscription";
    begin
        SalesInvLine.SetLoadFields("No.", "Sell-to Customer No.", "Posting Date");
        SalesInvline.SetRange("Document No.", SalesInvHdrNo);
        SalesInvline.SetRange(Type, SalesInvLine.Type::Item);
        if SalesInvLine.FindSet() then
            repeat
                CustomerSubscription.SetRange("Customer No.", SalesInvLine."Sell-to Customer No.");
                CustomerSubscription.SetRange("Item No.", SalesInvLine."No.");
                CustomerSubscription.SetRange("Subscription Code", SalesInvLine."CSD Subscription Code");
                if CustomerSubscription.FindFirst() then begin
                    SubScription.Get(CustomerSubscription."Subscription Code");
                    CustomerSubscription."Last Invoice Date" := SalesInvLine."Posting Date";
                    CustomerSubscription."Next Invoice Date" := CalcDate(SubScription."Invoicing Frequence", CustomerSubscription."Last Invoice Date");
                    if CustomerSubscription.Modify() then;
                end;
            until SalesInvline.Next() = 0;
    end;
}