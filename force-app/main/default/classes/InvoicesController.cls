public with sharing class InvoicesController {

    private Id oid;
    public Opportunity o {get;set;}
    public Decimal totalInvoices {get;set;}
    public Decimal invoiceRemainder {get;set;}
    public List<Invoice__c> newinvoices {get;set;}
    public Boolean isBalanced {get; set;}

    public InvoicesController(ApexPages.StandardSetController ssc) {
        oid = ApexPages.currentPage().getParameters().get('id');
        loadOpportunity();
    }

    private void loadOpportunity(){
        o = [SELECT Id, AccountId, Amount, CloseDate 
        FROM Opportunity
        WHERE Id = :oid LIMIT 1];
        invoiceRemainder = 0;
        if(newinvoices == null){
            newinvoices = new List<Invoice__c>();

            for (Integer i=0; i < 12; i++){
                Invoice__c inv = new Invoice__c();
                    inv.Opportunity__c = oid;
                    inv.Account__c = o.AccountId;
                    inv.Amount__c = 0;
                    inv.Due_Date__c = Date.today();
                newinvoices.add(inv);
            }
        }
        recalcTotalInvoices();
    }

    public PageReference save() {

        List<Invoice__c> invToCreate = new List<Invoice__c>();
        //check for entries and remove any $0 invoices
        for (Invoice__c inv : newinvoices){
            if(inv.Amount__c > 0){
                invToCreate.add(inv);
            }
        }

        //insert new invoices into database
        insert invToCreate;

        //Return the user to the applicable opportunity page
        PageReference pr = new PageReference('/'+oid);
        return pr;
    }

    public PageReference cancel() {
        //Return the user to the applicable opportunity page
        PageReference pr = new PageReference('/'+oid);
        return pr;
    }

    public void recalcTotalInvoices() {
        if(newinvoices == null){
            totalInvoices = 0;
        }
        else {
            totalInvoices = 0;
            for(Invoice__c inv : newinvoices){
                totalInvoices += inv.Amount__c;
            }
        }
        invoiceRemainder = o.Amount - totalinvoices;
        if(invoiceRemainder == 0 ){isBalanced = true;} else {isBalanced = false;}
    }
}