tableextension 50103 "CSD Sales Inv. Line" extends "Sales Invoice Line"
{
    fields
    {
        field(50100; "CSD Subscription Code"; Code[20])
        {
            Caption = 'Subscription Code';
            DataClassification = ToBeClassified;
        }
    }
}