codeunit 50147 "CSD Import Courses Rest"
{
    trigger OnRun();
    var
        Base64: Codeunit "Base64 Convert";
        AuthText: Text;
        AcceptTxt: label 'application/json; charset=utf-8';
        ContentTypeTxt: label 'application/x-www-form-urlencoded';
        UseridTxt: Label 'Webservice';
        PasswordTxt: Label 'Webservice123';
        EndPoint: label 'http://NAVTraining:7248/BC140_NavUser/OData/Company(''CRONUS%20International%20Ltd.'')/Courses', Comment = '%20=xxx';

    begin
        AuthText := StrSubstNo('%1:%2', UserIdTxt, PasswordTxt);
        RequestMessage.SetRequestUri(EndPoint);
        RequestMessage.Method('GET');
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type', ContentTypeTxt);
        RequestMessage.GetHeaders(HttpHeaders);
        HttpHeaders.Add('Authorization', StrSubstNo('Basic %1', Base64.ToBase64(AuthText)));
        HttpHeaders.Add('Accept', AcceptTxt);
        if not HttpClient.Send(RequestMessage, ResponseMessage) then
            Error('The call to the web service failed.');
        if not ResponseMessage.IsSuccessStatusCode then
            error('The web service returned an error message:\\' + 'Status code: %1\' + 'Description: %2', ResponseMessage.HttpStatusCode, ResponseMessage.ReasonPhrase);
        ResponseMessage.Content.ReadAs(JsonText);
        error('Response %1',JsonText);

        JsonText := CopyStr(JsonText, strpos(JsonText, '['));
        JsonText := CopyStr(JsonText, 1, StrLen(JsonText) - 1);
        if not JsonArray.ReadFrom(JsonText) then
            Error('Invalid response, expected an JSON Array object');
        foreach jsonToken in JsonArray do begin
            JsonObject := JsonToken.AsObject;
            InsertCourse();
        end;
        Message(FinishedTxt, Counter);
    end;

    local procedure InsertCourse();
    var
        TokenName: Text[50];
        LowerCurrCode: Text[10];
        //Seminar: Record "CSD Seminar";
        FieldText: Text;

    begin
        TokenName := 'Code';
        FieldText := delchr(format(SelectJsonToken(JsonObject, TokenName)), '=', '"');
        //Seminar."No." := FieldText;
        TokenName := 'Name';
        FieldText := delchr(format(SelectJsonToken(JsonObject, TokenName)), '=', '"');
        //Seminar.Name := FieldText;
        TokenName := 'Duration';
        FieldText := delchr(format(SelectJsonToken(JsonObject, TokenName)), '=', '"');
        //evaluate(Seminar."Seminar Duration", FieldText);
        TokenName := 'Price';
        FieldText := delchr(format(SelectJsonToken(JsonObject, TokenName)), '=', '"');
        //evaluate(Seminar."Seminar Price", FieldText);
        //Seminar.Validate("Gen. Prod. Posting Group", 'MISC');
        //Seminar."Minimum Participants" := 4;
        //Seminar."Maximum Participants" := 12;
        //if Seminar.Insert then
        //Counter += 1;
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text) JsonToken: JsonToken
    begin
        if not JsonObject.Get(TokenKey, JsonToken) then
            Error('Could not find a token with key %1', TokenKey);
    end;

    var
        HttpClient: HttpClient;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        JsonToken: JsonToken;
        JsonValue: JsonValue;
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonText: text;
        Counter: Integer;
        FinishedTxt: Label '%1 Courses inserted';
}