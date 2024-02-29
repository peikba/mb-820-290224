query 50100 "CSD WS Subscr. Cust"
{
    QueryType = Normal;

    elements
    {
        dataitem(Customer; Customer)
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            dataitem(SubscriptionCustomer; "CSD Customer Subscription")
            {
                DataItemLink = "Customer No." = Customer."No.";
                SqlJoinType = InnerJoin;

                column(ItemNo; "Item No.")
                {
                }
                column(SubscriptionCode; "Subscription Code")
                {
                }
                column(StartDate; "Start Date")
                {
                }
                column(LastInvoiceDate; "Last Invoice Date")
                {
                }
                column(NextInvoiceDate; "Next Invoice Date")
                {
                }
                column(InvoicingPrice; "Invoicing Price")
                {
                }
                column(Active; Active)
                {
                }
                dataitem(SalespersonPurchaser; "Salesperson/Purchaser")
                {
                    DataItemLink = Code = Customer."Salesperson Code";
                    column(SalesPersonName; Name)
                    {
                    }
                    dataitem(Country_Region; "Country/Region")
                    {
                        DataItemLink = Code = Customer."Country/Region Code";
                        column(CountryName; Name)
                        {
                        }
                    }
                }
            }
        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
}