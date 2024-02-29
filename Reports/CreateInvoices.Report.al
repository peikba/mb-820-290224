report 50101 "CSD Create Subscrip. Invoices"
{
    Caption = 'Create Subscription Invoices';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("CSD Customer Subscription"; "CSD Customer Subscription")
        {
            DataItemTableView = sorting("Customer No.", "Subscription Code") where(Active = const(true));
            RequestFilterFields = "Customer No.", "Item No.";

            trigger OnPreDataItem()
            begin
                SetFilter("Next Invoice Date", '<=%1', EndingDate);
            end;

            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
                Subscription: Record "CSD Subscription";
            begin
                if not SubscriptionInvoiceExists("Customer No.", "Item No.", "Next Invoice Date") then begin

                    if ("Customer No." <> Customer."No.") then begin
                        Customer.Get("Customer No.");
                        InsertSalesHeader("Customer No.", "Next Invoice Date");
                    end;
                    if "Next Invoice Date" = 0D then
                        "Next Invoice Date" := "Start Date";
                    Subscription.Get("Subscription Code");
                    InsertSalesLine("Item No.", "Subscription Code", 1, "Invoicing Price", "Allow Line Discount", "Next Invoice Date", CalcDate(Subscription."Invoicing Frequence", "Next Invoice Date"));
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(EndingDate2; EndingDate)
                    {
                        Caption = 'Create Invoices up until date';
                        ApplicationArea = All;
                        ToolTip = 'Create Invoices up until date';
                    }
                }
            }
        }

    }
    trigger OnPreReport()
    var
        RunWarningLbl: Label 'This report will create invoices for all active customers with a subscription Due. Do you want to continue?';
    begin
        if not Confirm(RunWarningLbl, false) then
            CurrReport.Quit();
        EndingDate := CalcDate('<CM>', workdate());
    end;


    trigger OnPostReport()
    var
        CreatedLbl: Label 'Created %1 invoices', Comment = '%1 = Number of invoices created';
    begin
        Message(CreatedLbl, CreateCounter);
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        EndingDate: Date;
        NextLineNo: Integer;
        CreateCounter: Integer;

    local procedure InsertSalesHeader(inCustomerNo: Code[20]; inStartingDate: Date)
    begin
        Clear(SalesHeader);
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", inCustomerNo);
        SalesHeader.Validate("Posting Date", inStartingDate);
        SalesHeader.Validate("Location Code", '');
        SalesHeader.Modify();
        NextLineNo := 10000;
        CreateCounter += 1;
    end;

    local procedure InsertSalesLine(inItemNo: Code[20]; inSubScriptionCode: Code[20]; inQuantity: Decimal; inUnitPrice: Decimal; inAllowLineDiscount: Boolean; inFromDate: Date; inToDate: Date)
    var
        SubscriptionValidLbl: Label 'The Subscription is valid from %1 to %2', Comment = '%1 = From Date %2 = To Date';
    begin
        SalesLine.Init();
        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Line No.", NextLineNo);
        SalesLine.Validate("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
        SalesLine.insert(true);
        SalesLine.Validate("Type", SalesLine.Type::Item);
        SalesLine.Validate("No.", inItemNo);
        SalesLine.Validate("Allow Line Disc.", inAllowLineDiscount);
        SalesLine.Validate("Quantity", inQuantity);
        SalesLine.Validate("Unit Price", inUnitPrice);
        SalesLine."CSD Subscription Code" := inSubScriptionCode;
        SalesLine.Modify();
        NextLineNo += 10000;
        SalesLine.Validate("Line No.", NextLineNo);
        SalesLine."CSD Subscription Code" := '';
        SalesLine."No." := '';
        SalesLine.insert(true);
        SalesLine.Validate("Type", SalesLine.Type::" ");
        SalesLine.Validate(Description, StrSubstNo(SubscriptionValidLbl, inFromDate, inToDate));
        SalesLine.Modify();
        NextLineNo += 10000;
    end;


    local procedure SubscriptionInvoiceExists(inCustomerNo: Code[20]; InItemNo: Code[20]; inStartDate: date): Boolean
    var
        TestSalesLine: Record "Sales Line";
    begin
        TestSalesLine.SetRange("Sell-to Customer No.", inCustomerNo);
        TestSalesLine.SetRange("Type", TestSalesLine.Type::Item);
        TestSalesLine.SetRange("No.", InItemNo);
        TestSalesLine.SetRange("Posting Date", inStartDate);
        TestSalesLine.SetRange("Document Type", TestSalesLine."Document Type"::Invoice);
        exit(not TestSalesLine.IsEmpty());
    end;
}