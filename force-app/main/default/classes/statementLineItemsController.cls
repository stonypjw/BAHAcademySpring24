global class statementLineItemsController {
    public statementLineItemsController() {
        String query = 'SELECT ID, Name, (SELECT ID,Opportunity__r.Name, Amount__c, Date_Paid__c, Due_Date__c FROM Invoices__r WHERE Invoice_Date__c = LAST_N_MONTHS:1  OR Date_Paid__c = LAST_N_MONTHS:1) FROM Account' +
        'WHERE Id = "accountId ';
        relatedInvoices = Database.query(query);
    }
    global String accountId { get; set; }
    global List<Invoice__c> relatedInvoices { get; set; }



}