codeunit 50146 MyCodeunit
{
    trigger OnRun()
    begin
        GetFloatRateCurrencies();
    end;
    
    local procedure GetFloatRateCurrencies()
    var
        Url: Label 'http://www.floatrates.com/daily/gbp.json';
        Currency: Record Currency;
    begin
        if not Client.Get(Url, Response) then
            Error('Could not connect');
        if not Response.IsSuccessStatusCode then
            Error('Could not connect, error message is %1', Response.ReasonPhrase);
        Response.Content.ReadAs(JsonText);
        JsonText := '[' + JsonText + ']';
        JsonArr.ReadFrom(JsonText);
        foreach jsonTok in JsonArr do begin
            JsonObj := jsonTok.AsObject();
            if Currency.FindSet() then
                repeat
                    InsertCurrencyRate(Currency.Code);
                until Currency.Next() = 0;
        end;
        Page.run(0, TempCurrencyRate);
    end;

    local procedure InsertCurrencyRate(inCurrencyCode: code[10])
    var
        TokenText: Text[50];
        CurrCodeLower: Text[10];
        InvExchRate: Decimal;
        InvExchRateTxt: Text;
    begin
        TempCurrencyRate.Init();
        CurrCodeLower := LowerCase(inCurrencyCode);
        if not Jsonobj.Get(CurrCodeLower, JsonTok) then
            exit;
        TokenText := '$.' + CurrCodeLower + '.code';
        TempCurrencyRate."Currency Code" := format(SelectJsonToken(JsonObj, TokenText));
        TempCurrencyRate."Exchange Rate Amount" := 100;
        TokenText := '$.' + CurrCodeLower + '.inverseRate';
        InvExchRateTxt := format(SelectJsonToken(JsonObj, TokenText));
        evaluate(InvExchRate, InvExchRateTxt.Replace('.', ','));
        TempCurrencyRate."Relational Exch. Rate Amount" := InvExchRate;
        TokenText := '$.' + CurrCodeLower + '.date';
        TempCurrencyRate."Starting Date" := ConvertDate(format(SelectJsonToken(JsonObj, TokenText)));
        if TempCurrencyRate.Insert then;
    end;

    local procedure ConvertDate(inDateTxt: Text[50]): Date;
    var
        DayTxt: Text[10];
        MonthTxt: Text[10];
        YearTxt: Text[10];
        DayNo: Integer;
        MonthNo: Integer;
        YearNo: Integer;
        DateTxt: Text[50];

    begin
        //date":"Thu, 27 Sep 2018 00:00:01
        DateTxt := copystr(inDateTxt, strpos(inDateTxt, ',') + 1);
        DateTxt := DelChr(DateTxt, '<', ' ');
        DayTxt := CopyStr(DateTxt, 1, StrPos(DateTxt, ' '));
        DateTxt := copystr(DateTxt, strpos(DateTxt, ' ') + 1);
        MonthTxt := CopyStr(DateTxt, 1, StrPos(DateTxt, ' '));
        DateTxt := copystr(DateTxt, strpos(DateTxt, ' ') + 1);
        YearTxt := CopyStr(DateTxt, 1, StrPos(DateTxt, ' '));
        evaluate(DayNo, DayTxt);
        evaluate(YearNo, YearTxt);
        case lowercase(delchr(MonthTxt, '=', ' ')) of
            'jan':
                MonthNo := 1;
            'feb':
                MonthNo := 2;
            'mar':
                MonthNo := 3;
            'apr':
                MonthNo := 4;
            'may':
                MonthNo := 5;
            'jun':
                MonthNo := 6;
            'jul':
                MonthNo := 7;
            'aug':
                MonthNo := 8;
            'sep':
                MonthNo := 9;
            'oct':
                MonthNo := 10;
            'nov':
                MonthNo := 11;
            'dec':
                MonthNo := 12;
        end;
        exit(DMY2Date(DayNo, MonthNo, YearNo));
    end;

    procedure SelectJsonToken(JsonObject: JsonObject; Path: text) JsonToken: JsonToken
    begin
        if not JsonObject.SelectToken(Path, JsonToken) then
            Error('Could not find a token with path %1', Path);
    end;

    var
        Client: HttpClient;
        Response: HttpResponseMessage;
        JsonText: Text;
        JsonArr: JsonArray;
        jsonTok: JsonToken;
        JsonObj: JsonObject;
        TempCurrencyRate: Record "Currency Exchange Rate" temporary;
}