@isTest
private class invoicescontrollertest {

    @isTest
    static void testSave() {
        //Gather ingredients
        //need an invoice
        //need a linked opportunity
        //need a linked account
        Account testAccount = new Account(Name='Test');
        insert testAccount;
        List<Opportunity> testOpp = new List<Opportunity>();
        Opportunity o = new Opportunity();
            o.AccountId = testAccount.Id;
            o.Name = 'Test';
            o.Type = 'New Customer';
            o.Amount = 120000;
            o.StageName = 'Closed Lost';
            o.CloseDate = Date.today();
        insert o;
        //need an instance of the class

        ApexPages.StandardSetController testSSC 
                      = new ApexPages.StandardSetController(new List<Opportunity>{o});
        
         Invoice__c testInvoice = new Invoice__c();
            testInvoice.Opportunity__c = o.Id;
            testInvoice.Account__c = o.AccountId;
            testInvoice.Amount__c = o.Amount;
            testInvoice.Due_Date__c = o.CloseDate + 90;
        PageReference testPage = new PageReference('/');
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', o.Id);
        InvoicesController invExt = new InvoicesController(testSSC);
        invExt.newinvoices.add(testInvoice);
        
        TEst.startTest();
        //Do something that needs testing
        PageReference testPR = invExt.save();
        test.stopTest();

        //Checks to see everything worked
        System.assertEquals('/'+o.Id, testPR.getUrl(), 'Incorrect return URL');
        List<Invoice__c> savedInvoices = [SELECT Id FROM Invoice__c];
        System.assertEquals(1,savedInvoices.size() , 'Incorrect number of invoices created');
    }

    @isTest
    static void testCancel() {
        //Gather ingredients
        //need an invoice
        //need a linked opportunity
        //need a linked account
        Account testAccount = new Account(Name='Test');
        insert testAccount;
        List<Opportunity> testOpp = new List<Opportunity>();
        Opportunity o = new Opportunity();
            o.AccountId = testAccount.Id;
            o.Name = 'Test';
            o.Type = 'New Customer';
            o.Amount = 120000;
            o.StageName = 'Closed Lost';
            o.CloseDate = Date.today();
        insert o;
        //need an instance of the class

        ApexPages.StandardSetController testSSC 
                      = new ApexPages.StandardSetController(new List<Opportunity>{o});
        
         Invoice__c testInvoice = new Invoice__c();
            testInvoice.Opportunity__c = o.Id;
            testInvoice.Account__c = o.AccountId;
            testInvoice.Amount__c = o.Amount;
            testInvoice.Due_Date__c = o.CloseDate + 90;
        PageReference testPage = new PageReference('/');
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', o.Id);
        InvoicesController invExt = new InvoicesController(testSSC);
        invExt.newinvoices.add(testInvoice);
        
        TEst.startTest();
        //Do something that needs testing
        PageReference testPR = invExt.cancel();
        test.stopTest();

        //Checks to see everything worked
        System.assertEquals('/'+o.Id, testPR.getUrl(), 'Incorrect return URL');
        List<Invoice__c> savedInvoices = [SELECT Id FROM Invoice__c];
        System.assertEquals(0,savedInvoices.size() , 'Incorrect number of invoices created');


    }
}