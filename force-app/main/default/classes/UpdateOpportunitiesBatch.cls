global class UpdateOpportunitiesBatch implements Database.Batchable<sObject> {

    // get all opportunities in the org so that they can be updated
    global Database.QueryLocator start (Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT ID FROM Opportunity');
    }

    // cause the before update event to then call applyNamingConvention method
    global void execute(Database.BatchableContext bc, List<Opportunity> opps){
        Database.update(opps,false);
    }

    //Do stuff on completion as needed
    global void finish(Database.BatchableContext bc){
        system.debug('Batch process: '+bc.getJobId() + ' completed');
    }

}