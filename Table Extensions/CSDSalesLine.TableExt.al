tableextension 50102 "CSD Sales Line" extends "Sales Line"
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