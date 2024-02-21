global class presentMonthlyStatement implements Database.Batchable<sObject> {


    global Database.QueryLocator start (Database.BatchableContext bc){      
        String query = 'SELECT ID,Last_Statement_Date__c FROM Account' +
        'WHERE Id IN (SELECT Account__c FROM Invoice__c WHERE Invoice_Date__c = LAST_N_MONTHS:1 ' +
        'OR Date_Paid__c = LAST_N_MONTHS:1';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accs){
        List<Monthly_Statement__c> statementBatch = new List<Monthly_Statement__c>();
        for (Account a : accs){
            a.Last_Statement_Date__c = Date.today();
        }
        Database.update(accs,false);
    }

    //Do stuff on completion as needed
    global void finish(Database.BatchableContext bc){
        system.debug('Batch process: '+bc.getJobId() + ' completed');
    }

}