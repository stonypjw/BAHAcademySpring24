global class presentInvoicesSchedule implements Schedulable {

    //implement execute method to schedule batch class
    global void execute(SchedulableContext sc){
        Id batchInstanceId = Database.executeBatch(new invoiceDelivery());
        System.Debug('BatchId: '+batchInstanceId);
    }
}