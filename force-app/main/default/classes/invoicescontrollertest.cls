@isTest
private class invoicescontrollertest {

    @isTest
    static void testSave() {
        //Gather ingredients
        //need an invoice
        //need a linked opportunity
        //need a linked account
        Account testAccount = new Account(Name='Test');
        insert a;
        List<Opportunity> testOpp = new List<Opportunity>();
        Opportunity o = new Opportunity();
            o.AccountId = a.Id;
            o.Name = 'Test';
            o.Type = 'New Customer';
            o.Amount = 120000;
            o.StageName = 'Closed Lost';
            o.CloseDate = Date.today();
        insert o;
        testOpp.add(o);
        //need an instance of the class
        ApexPages.StandardSetController testSSC 
                      = new ApexPages.StandardSetController(new List<Opportunity>{ testOpp });
        
         Invoice__c testInvoice = new Invoice__c();
            testInvoice.Opportunity__c = o.Id;
            testInvoice.Account__c = o.AccountId;
            testInvoice.Amount__c = o.Amount;
            testInvoice.Due_Date__c = o.CloseDate + 90;
        
        InvoicesController invExt = new InvoicesController(testSSC);
        invExt.newinvoices.add(testInvoice);

        TEst.startTest();
        //Do something that needs testing
        PageReference testPR = invExt.save();
        test.stopTest();

        //Checks to see everything worked
        
    }
}