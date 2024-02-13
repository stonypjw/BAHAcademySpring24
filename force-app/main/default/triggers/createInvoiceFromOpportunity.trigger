trigger createInvoiceFromOpportunity on Opportunity (after update) {
    
    //Get ingredients
    //Everything is already in trigger.new
    
    //Do work
    // create a list to hold my new invoices to be created
    List<Invoice__c> invToCreate = new List<Invoice__c>();
    
    // iterate over the records and check the stage for Closed-Won
    for (Opportunity opp : trigger.new) {
        if (opp.isWon && !trigger.oldMap.get(opp.Id).isWon) {
            Invoice__c inv = new Invoice__c();
            inv.Account__c          = opp.AccountId;
            inv.Opportunity__c      = opp.Id;
            inv.Amount__c           = opp.Amount;
            inv.Due_Date__c         = opp.CloseDate + 30;
            // add the Invoice record to the list of invoices to be created
            invToCreate.add(inv);
        }
        
        
        
    }
    
    
    

    

    // iterate over the records and check the stage for Closed-Won
    for (Opportunity opp : trigger.new) {
    // check to see if the new Opp is set to Closed Won
        if (opp.isWon) {
            Invoice__c inv = new Invoice__c();
            inv.Account__c          = opp.AccountId;
            inv.Opportunity__c      = opp.Id;
            inv.Amount__c           = opp.Amount;
            inv.Due_Date__c         = opp.CloseDate + 30;
            // add the Invoice record to the list of invoices to be created
            invToCreate.add(inv);
        }
    }

    // if its an existing Opportunity, check to see if the stage is closed won
    if (trigger.isUpdate) {
        for (Opportunity opp : trigger.new) {
        // check to see if the stage changed to Closed Won
        
    }
}
    
    //Submit to database 

    // check to see if my list of invoices has any values, and if so, insert them into the database
    if (!invToCreate.isEmpty()) {
        Database.insert(invToCreate,false);         // insert the new invoices into the database
    }
}