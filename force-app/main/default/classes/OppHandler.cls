public with sharing class OppHandler {

    public static void applyNamingConvention(List<Opportunity> triggernew){

    //trigger.new will be a List<Opportunity> that need to be processed
    //Naming convention is Account Name - Opportunity Type - CloseMonth/Close Year
    //PART ONE - Gather ingredients
    //Retrieve any Account Names that we need
    Map<Id,Account> parentAccounts = new Map<Id,Account>();
    Set<Id> parentIds = new Set<Id>();
    for(Opportunity o : triggernew){
        parentIds.add(o.AccountId);
    }
    for(Account a : [SELECT Id, Name FROM Account WHERE Id IN :parentIds]){
        parentAccounts.put(a.Id,a);
    }
    //PART TWO - Do the work
    //Update all the opportunities so that the name field matches the convention
    for (Opportunity o : triggernew){
        o.Name = parentAccounts.get(o.AccountId).Name + ' - ' + o.Type + ' - ' +
                 String.valueof(o.CloseDate.month()) +'/'+ String.valueof(o.CloseDate.year());
    }

    }

    public static Invoice__c createInvoice(Opportunity opp){
        Invoice__c inv = new Invoice__c();
        inv.Account__c          = opp.AccountId;
        inv.Opportunity__c      = opp.Id;
        inv.Amount__c           = opp.Amount;
        inv.Due_Date__c         = opp.CloseDate + 30;
        return inv;
    }

    public static void createInvoiceFromOpportunity(List<Opportunity> triggernew, Map<Id,Opportunity> triggeroldmap){
       
        List<Invoice__c> invToCreate = new List<Invoice__c>();

        // iterate over the records and check the stage for Closed-Won
        for (Opportunity opp : triggernew) {
                  
        // if its an existing Opportunity, check to see if the stage is closed won
       
            // check to see if the stage changed to Closed Won
            if (opp.isWon && !triggeroldMap.get(opp.Id).isWon) {
                                // add the Invoice record to the list of invoices to be created
                invToCreate.add(createInvoice(opp));
            }
    
    }
        
        //Submit to database 
        // check to see if my list of invoices has any values, and if so, insert them into the database
        if (!invToCreate.isEmpty()) {
            Database.insert(invToCreate,false);         // insert the new invoices into the database
        }
    }

    public static void createInvoiceFromOpportunity(List<Opportunity> triggernew){
       
        List<Invoice__c> invToCreate = new List<Invoice__c>();
        // iterate over the records and check the stage for Closed-Won
        for (Opportunity opp : triggernew) {
        // if its an existing Opportunity, check to see if the stage is closed won
            // check to see if the stage changed to Closed Won
            if (opp.isWon) {
                                // add the Invoice record to the list of invoices to be created
                invToCreate.add(createInvoice(opp));
            }
    }
        
        //Submit to database 
        // check to see if my list of invoices has any values, and if so, insert them into the database
        if (!invToCreate.isEmpty()) {
            Database.insert(invToCreate,false);         // insert the new invoices into the database
        }
    }

}