global class presentMonthlyStatementSchedule implements Schedulable {

    //implement execute method to schedule batch class
    global void execute(SchedulableContext sc){
        Id batchInstanceId = Database.executeBatch(new presentMonthlyStatement());
        System.Debug('BatchId: '+batchInstanceId);
    }
}