public  class ReceivePaymentsController {
    public ReceivePaymentsController(ApexPages.StandardController controller) {
        this.stdController = controller;
        aid = stdController.getId();
        loadAccount();
    }
    private ApexPages.StandardController stdController;


    private Id aid;
    public Account acc {get;set;}

    public List<Invoice__c> newinvoices{get; set;}

    private void loadAccount(){
        acc = [SELECT Id, Name, (SELECT ID,Opportunity__c,Amount__c,Due_Date__c,isFee__c,latefeeApplied__c,Paid__c,Invoice_Date__c,Billing_Contact__c FROM Invoices__r WHERE Paid__c = false)
        FROM Account
        WHERE Id = :aid LIMIT 1];

        newInvoices = new List<Invoice__c>(acc.Invoices__r);
        

    }

    public PageReference save() {

        List<Invoice__c> invToUpdate = new List<Invoice__c>();

       
        for (Invoice__c inv : newinvoices){
           
                    invToUpdate.add(inv);
            
            }
        


        update invToUpdate;
 



        //Return the user to the applicable opportunity page
        PageReference pr = new PageReference('/'+aid);
        return pr;
    }

    public PageReference cancel() {
        //Return the user to the applicable opportunity page
        PageReference pr = new PageReference('/'+aid);
        return pr;
    }
}