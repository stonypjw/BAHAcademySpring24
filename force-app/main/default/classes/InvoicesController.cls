public with sharing class InvoicesController {
    private Id oid;
    public Opportunity o {get;set;}
    public Decimal totalInvoices { get; set; }
    public Decimal expectedAmount {get; set; }
    public Decimal invoiceRemainder { get; set; }
    public Boolean isBalanced {get; set;}


    public List<Invoice__c> newinvoices{get; set;}

    public invoicescontroller(ApexPages.StandardSetController ssc) {
        oid = ApexPages.currentPage().getParameters().get('id');
        loadOpportunity();
    }

    private void loadOpportunity(){
        o = [SELECT Id, AccountId, Account.Billing_Contact__c,Amount, CloseDate,invoiceLeadTime__c, (SELECT ID,Account__c,Opportunity__c,Amount__c,Due_Date__c,isFee__c,latefeeApplied__c,Paid__c,Invoice_Date__c,Billing_Contact__c FROM Invoices__r)
        FROM Opportunity
        WHERE Id = :oid LIMIT 1];
        invoiceRemainder = 0;
        expectedAmount = o.Amount;
        //Check existing invoices for fees 
        for(Invoice__c inv : o.Invoices__r){
            if(inv.isFee__c){expectedAmount += inv.Amount__c;}
        }
        if (o.Invoices__r.size() > 0){
            newinvoices = new List<Invoice__c>(o.Invoices__r);
                for (Integer i=0; i < (12 - o.Invoices__r.size()); i++){
                    Invoice__c inv = new Invoice__c();
                        inv.Opportunity__c = oid;
                        inv.Account__c = o.AccountId;
                        inv.Amount__c = 0;
                        inv.Due_Date__c = Date.today()+Integer.valueOf(o.invoiceLeadTIme__c);
                        inv.Invoice_Date__c = Date.today();
                        inv.Billing_Contact__c = o.Account.Billing_Contact__c;
                    newinvoices.add(inv);
                }
        }
        else {
            newinvoices = new List<Invoice__c>();

                for (Integer i=0; i < 12; i++){
                    Invoice__c inv = new Invoice__c();
                        inv.Opportunity__c = oid;
                        inv.Account__c = o.AccountId;
                        inv.Amount__c = 0;
                        inv.Due_Date__c = Date.today()+Integer.valueOf(o.invoiceLeadTIme__c);
                        inv.Invoice_Date__c = Date.today();
                        inv.Billing_Contact__c = o.Account.Billing_Contact__c;
                    newinvoices.add(inv);
                }
        }
        recalcTotalInvoices();
    }


    public void recalcTotalInvoices(){

        if(newinvoices == null){
                totalInvoices = 0;
            }
            else {
                totalInvoices = 0;
                for(Invoice__c inv : newInvoices){
                    totalInvoices += inv.Amount__c;
                }
            }
        
        invoiceRemainder = expectedAmount - totalInvoices;
        if(invoiceRemainder == 0 ){isBalanced = true;} else {isBalanced = false;}
    }

    public PageReference save() {

        List<Invoice__c> invToDelete = new List<Invoice__c>();
        List<Invoice__c> invToUpdate = new List<Invoice__c>();
        List<Invoice__c> invToCreate = new List<Invoice__c>();
        //check for existing entries and remove any $0 invoices, update the rest
        //insert any new entries
        for (Invoice__c inv : newinvoices){
            if(inv.Amount__c > 0){
                if(inv.Id != null){
                    inv.Invoice_Date__c = inv.Due_Date__c - Integer.valueof(o.invoiceLeadTIme__c);
                    invToUpdate.add(inv);
                }
                else{
                    inv.Invoice_Date__c = inv.Due_Date__c - Integer.valueof(o.invoiceLeadTIme__c);
                    invToCreate.add(inv);
                }  
            }
            else {
                if(inv.Id != null){
                    invToDelete.add(inv);
                }
            }
        }
        //insert new invoices into database
        delete invToDelete;
        update invToUpdate;
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
}