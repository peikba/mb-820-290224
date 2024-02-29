xmlport 50100 "CSD Export Cust Subscription"
{
    Direction = Export;

    schema
    {
        textelement(NodeName1)
        {
            tableelement(Cust; Customer)
            {
                MinOccurs=zero;
                SourceTableView=where("CSD Subscription Customer"=const(true));
                fieldattribute(No; Cust."No.")
                {

                }
                fieldattribute(Name; Cust.Name)
                {

                }
                tableelement("CustomerSubscription"; "CSD Customer Subscription")
                {
                    LinkTable = cust;
                    LinkFields = "Customer No." = field("No.");
                    SourceTableView = sorting("Customer No.", "Subscription Code");
                    MinOccurs=Zero;

                    fieldelement(ItemNo;
                    CustomerSubscription."Item No.")
                    {
                    }
                fieldelement(SubscriptionCode; CustomerSubscription."Subscription Code")
                {
                }
                fieldelement(StartDate; CustomerSubscription."Start Date")
                {
                }
                fieldelement(LastInvoiceDate; CustomerSubscription."Last Invoice Date")
                {
                }
                fieldelement(NextInvoiceDate; CustomerSubscription."Next Invoice Date")
                {
                }
                fieldelement(InvoicingPrice; CustomerSubscription."Invoicing Price")
                {
                }
                fieldelement(Active; CustomerSubscription.Active)
                {
                }
            }
        }
    }
}
}