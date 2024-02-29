codeunit 50149 "CSD Install Subscription"
{
    Subtype = Install;
    trigger OnInstallAppPerCompany()
    var
        myInt: Integer;
        InitialInstallLbL: Label 'InitialInstallLbL';
        UpgradeTag: Codeunit "Upgrade Tag";

    begin
        if not UpgradeTag.HasUpgradeTag(InitialInstallLbL) then begin
            UpgradeTag.SetUpgradeTag(InitialInstallLbL);
            CreateSubscriptions();
            CreateCustomerSubscriptions();
        end;
    end;

    local procedure CreateSubscriptions()
    var
        Subscription: Record "CSD Subscription";
    begin
        Subscription.init();
        Subscription.Code := 'BC6MONTHS';
        Subscription.Name := 'BC 6 Months Subscription';
        Subscription.Validate("Item No.", '70061');
        Evaluate(Subscription."Invoicing Frequence", '6M');
        Subscription."Invoicing Schedule" := Subscription."Invoicing Schedule"::"Posting Date";
        Subscription."Invoicing Price" := 1200;
        if Subscription.Insert() then;

        Subscription.init();
        Subscription.Code := 'BC12MONTHS';
        Subscription.Name := 'BC 12 Months Subscription';
        Subscription.Validate("Item No.", '70061');
        Evaluate(Subscription."Invoicing Frequence", '12M');
        Subscription."Invoicing Schedule" := Subscription."Invoicing Schedule"::"Posting Date";
        Subscription."Invoicing Price" := 2400;
        if Subscription.Insert() then;
    end;

    local procedure CreateCustomerSubscriptions()
    var
        CustSub: Record "CSD Customer Subscription";
    begin
        CustSub.Init();
        CustSub.Validate("Customer No.", '10000');
        CustSub.Validate("Subscription Code", 'BC6MONTHS');
        CustSub.Validate(Active, true);
        if CustSub.Insert() then;
        CustSub.Init();
        CustSub.Validate("Customer No.", '10000');
        CustSub.Validate("Subscription Code", 'BC12MONTHS');
        CustSub.Validate(Active, true);
        if CustSub.Insert() then;
        CustSub.Init();
        CustSub.Validate("Customer No.", '20000');
        CustSub.Validate("Subscription Code", 'BC6MONTHS');
        CustSub.Validate(Active, true);
        if CustSub.Insert() then;
        CustSub.Init();
        CustSub.Validate("Customer No.", '20000');
        CustSub.Validate("Subscription Code", 'BC12MONTHS');
        CustSub.Validate(Active, true);
        if CustSub.Insert() then;
    end;
}