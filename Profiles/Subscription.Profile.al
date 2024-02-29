profile "CSD Subscription"
{
    Caption = 'Subscription RC';
    RoleCenter = "Sales Manager Role Center";
    ProfileDescription = 'Subscription Role Center';
    Customizations = "CSD MyCustomizations";
}

pagecustomization "CSD MyCustomizations" customizes "Customer List"
{
    actions
    {
        modify(PaymentRegistration)
        {
            Visible = false;
        }
    }

    views
    {
        addfirst
        {
            view(BalanceLCY)
            {
                Caption = 'Hello World';
                OrderBy = ascending("Balance (LCY)");
                SharedLayout = false;

                layout
                {

                }
            }
        }
    }
}