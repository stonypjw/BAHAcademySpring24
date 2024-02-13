global class CreditCheckRequest {

    global static void CreditCheck(String accountId){

        callCreditCheckAPI(accountId);

    }

    @future (callout=true)
    public static void callCreditCheckAPI(String accountId){

        Account acct = [SELECT Id,
                               Name,
                               Owner.Name,
                               Owner.Email
                        FROM Account
                        WHERE ID = :accountId
                        LIMIT 1];

    
        String url = 'https://splx201-developer-edition.na124.force.com';
        url += '?name='+EncodingUtil.urlEncode(acct.Name, 'UTF-8');
        url += '&email='+acct.Owner.Email;
        url += '&requestor='+EncodingUtil.urlEncode(acct.Owner.Name, 'UTF-8');

        system.debug(url);

        Http h = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');

        HttpResponse res = h.send(req);

        System.Debug('HTTP Response: '+res.getBody());
    }
}