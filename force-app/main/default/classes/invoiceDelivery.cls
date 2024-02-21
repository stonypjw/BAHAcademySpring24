global class invoiceDelivery implements Database.Batchable<sObject> {


    global Database.QueryLocator start (Database.BatchableContext bc){
        Date cutoffDate = Date.today();
        
        String query = 'SELECT ID FROM Invoice__c ' +
        'WHERE Invoice_Date__c > :cutoffDate AND PresentInvoice__c = false';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Invoice__c> invs){
        for (Invoice__c i : invs){
            i.PresentInvoice__c = true;
        }
        Database.update(invs,false);
    }

    //Do stuff on completion as needed
    global void finish(Database.BatchableContext bc){
        system.debug('Batch process: '+bc.getJobId() + ' completed');
    }

}