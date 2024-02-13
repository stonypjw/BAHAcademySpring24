global class UpdateAllOpportunities implements Schedulable {

    //implement execute method to schedule batch class
    global void execute(SchedulableContext sc){
        Id batchInstanceId = Database.executeBatch(new UpdateOpportunitiesBatch());
        System.Debug('BatchId: '+batchInstanceId);
    }
}