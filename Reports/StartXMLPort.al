report 50130 "CSD Start XMLPort"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = false;

    trigger OnPreReport()
    var
    begin
        Codeunit.Run(50145); //Get FloatRate
        //Codeunit.Run(50147); //Get Courses
        //GetFloatRateCurrencies();
        //TestAzureFunction();
        //CallWebService1();
        //Codeunit.run(50140);
        //Xmlport.Run(50100);        

    end;

    local procedure CallWebService1()
    var
        TenantMedia: Record "Tenant Media";
        Item: Record Item;
        Client: HttpClient;
        Content: HttpContent;
        ResponseMessage: HttpResponseMessage;
        Stream: InStream;
        Url: Text;
    begin
        Item.Get('1936-S');
        if not (Item.Picture.Count() > 0) then
            exit;

        if not TenantMedia.Get(Item.Picture.Item(1)) then
            exit;

        TenantMedia.CalcFields(Content);

        if not TenantMedia.Content.HasValue() then
            exit;

        TenantMedia.Content.CreateInStream(Stream);

        Content.WriteFrom(Stream);
        Url := 'https://mywebsite.com/ImageConverter';
        if not client.Post(Url, Content, ResponseMessage) then
            exit;

        if not ResponseMessage.IsSuccessStatusCode() then
            exit;

        ResponseMessage.Content().ReadAs(Stream);
        Clear(Item.Picture);
        Item.Picture.ImportStream(Stream, 'New Image');
        Item.Modify(true);
    end;

    local procedure TestAzureFunction()
    var
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        Content: HttpContent;
        Object: JsonObject;
        JsonText: Text;
        Url: Text;
        Cust: Record Customer;
    begin
        Cust.get('10000');
        Url := 'https://peik123456789.azurewebsites.net';
        Object.Add('name', Cust.Name);
        Object.WriteTo(JsonText);
        Content.WriteFrom(JsonText);
        if not Client.Post(Url, Content, ResponseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode() then
            Error('The web service returned an error message:\\' +
                'Status code: %1\' +
                'Description: %2',
                ResponseMessage.HttpStatusCode(),
                ResponseMessage.ReasonPhrase());
        ResponseMessage.Content().ReadAs(JsonText);

        Message(JsonText);
    end;
}