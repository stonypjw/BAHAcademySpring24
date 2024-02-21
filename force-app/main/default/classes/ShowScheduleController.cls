public with sharing class ShowScheduleController {
    private ApexPages.StandardController stdController;

    public ShowScheduleController(ApexPages.StandardController controller) {
        this.stdController = controller;
        aid = stdController.getId();
        loadAccount();
    }

    private Id aid;
    public Account acc {get;set;}

    public List<Invoice__c> newinvoices{get; set;}

    private void loadAccount(){
        acc = [SELECT Id, Name, (SELECT ID,Opportunity__c,Amount__c,Due_Date__c,isFee__c,latefeeApplied__c,Paid__c,Invoice_Date__c,Billing_Contact__c FROM Invoices__r WHERE Due_Date__c >= TODAY )
        FROM Account
        WHERE Id = :aid LIMIT 1];

        newInvoices = new List<Invoice__c>(acc.Invoices__r);
        

    }


}