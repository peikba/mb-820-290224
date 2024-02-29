report 50130 "CSD Start XMLPort"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly=true;
    UseRequestPage=false;
    
    trigger OnPreReport()
    begin
        Xmlport.Run(50100);        
    end;
}