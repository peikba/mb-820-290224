query 50101 "APISubscriptionCustomer"
{
    QueryType = API;
    APIPublisher = 'Developer';
    APIGroup = 'GroupName';
    APIVersion = 'v2.0';
    EntityName = 'SubscriptionCustomer';
    EntitySetName = 'SubscriptionCustomers';

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
            dataitem(subscriptionCustomer; "CSD Customer Subscription")
            {
                DataItemLink = "Customer No." = Customer."No.";
                SqlJoinType = InnerJoin;

                column(itemNo; "Item No.")
                {
                }
                column(subscriptionCode; "Subscription Code")
                {
                }
                column(startDate; "Start Date")
                {
                }
                column(lastInvoiceDate; "Last Invoice Date")
                {
                }
                column(nextInvoiceDate; "Next Invoice Date")
                {
                }
                column(invoicingPrice; "Invoicing Price")
                {
                }
                column(active; Active)
                {
                }
                dataitem(salespersonPurchaser; "Salesperson/Purchaser")
                {
                    DataItemLink = Code = Customer."Salesperson Code";
                    column(salesPersonName; Name)
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
}