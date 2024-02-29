report 50131 "CSD Start XMLPort from code"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    trigger OnPreReport()
    var
        OutFileName: Text;
        FileMgt: Codeunit "File Management";
        OutStr: OutStream;
        InStr: InStream;
        XMLSubCust: XmlPort "CSD Export Cust Subscription";
        TempBlob: Codeunit "Temp Blob";

    begin
        OutFileName := 'c:\temp\SubCust.xml';
        TempBlob.CreateOutStream(OutStr);
        XMLSubCust.SetDestination(OutStr);
        XMLSubCust.Export();
        TempBlob.CreateInStream(InStr);
        File.DownloadFromStream(Instr,'Download XML?','',FileMgt.GetToFilterText('',OutFileName),OutFileName);
    end;
}