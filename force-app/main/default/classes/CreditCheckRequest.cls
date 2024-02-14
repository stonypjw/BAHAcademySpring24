global class CreditCheckRequest {

    @InvocableMethod (label='Credit Check Request'
                      description='Sends a request to Credit Check service')
    global static void CreditCheck(List<String> accountIds){

        callCreditCheckAPI(accountIds[0]);
        System.Debug('This ran without waiting for the credit checks');

    }

    @future (callout=true)
    public static void callCreditCheckAPI(String accountId){

        Account acct = [SELECT Id,
                               Name,
                               CreditCheckId__c,
                               Owner.Name,
                               Owner.Email
                        FROM Account
                        WHERE ID = :accountId
                        LIMIT 1];

    
        String url = 'https://steve-wasula-splx201-dev-ed.my.salesforce-sites.com/creditcheck';
        url += '?name='+EncodingUtil.urlEncode(acct.Name, 'UTF-8');
        url += '&email='+acct.Owner.Email;
        url += '&requestor='+EncodingUtil.urlEncode(acct.Owner.Name, 'UTF-8');

        system.debug(url);

        Http h = new Http();

        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');

        HttpResponse res = h.send(req);

        System.Debug('HTTP Response: '+res.getStatusCode());
        System.Debug('HTTP Response: '+res.getStatus());
        System.Debug('HTTP Response: '+res.getBody());

        /*Example return structure
        {"type":"Credit_Check__c",
        "url":"/services/data/v60.0/sobjects/Credit_Check__c/a023u00001UgbcjAAB"},
        "Company_Name__c":"Burlington Textiles Corp of America",
        "Requestor_Name__c":"Jeremy White",
        "Requestor_Email__c":"jeremy.white@stonyp.com",
        "Name":"Jeremy White Burlington Textiles Corp of America",
        "Id":"a023u00001UgbcjAAB"}
        */

        ccReturn ccResponse = (ccReturn) JSON.deserialize(res.getBody(), ccReturn.class);
        System.Debug(ccResponse.Name);

        acct.CreditCheckId__c = ccResponse.Id;
        update acct;



    }

    public class ccReturn {
        public String type;
        public String url;
        public String Company_Name_c;
        public String Requestor_Name_c;
        public String Requestor_Email_c;
        public String Name;
        public String Id;
    }
}