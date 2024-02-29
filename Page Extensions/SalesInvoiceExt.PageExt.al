pageextension 50102 "CSD SalesInvoiceExt" extends "Sales Invoice"
{
    layout
    {
        addfirst(factboxes)
        {
            part("CSD CustInfoCardPart"; "CSD CustInfoCardPart")
            {
                SubPageLink = "No." = field("Bill-to Customer No.");
                ApplicationArea = All;
            }
        }
    }
}