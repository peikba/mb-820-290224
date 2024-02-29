permissionset 50100 GeneratedPermission
{
    Assignable = true;
    Permissions = tabledata "CSD Customer Subscription"=RIMD,
        tabledata "CSD Subscription"=RIMD,
        table "CSD Customer Subscription"=X,
        table "CSD Subscription"=X,
        report "CSD Create Subscrip. Invoices"=X,
        report "CSD Customer Suscriptions"=X,
        report "CSD Start XMLPort"=X,
        report "CSD Start XMLPort from code"=X,
        codeunit "CSD Event Subscriptions"=X,
        codeunit "CSD Install Subscription"=X,
        xmlport "CSD Export Cust Subscription"=X,
        page "CSD Customer Subscriptions"=X,
        page "CSD Subscription Card"=X,
        page "CSD Subscription FactBox"=X,
        page "CSD Subscription List"=X;
}