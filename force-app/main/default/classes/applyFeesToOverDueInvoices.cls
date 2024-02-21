global class applyFeesToOverDueInvoices implements Schedulable {

    //implement execute method to schedule batch class
    global void execute(SchedulableContext sc){
        Id batchInstanceId = Database.executeBatch(new invoiceOverDueBatch());
        System.Debug('BatchId: '+batchInstanceId);
    }
}