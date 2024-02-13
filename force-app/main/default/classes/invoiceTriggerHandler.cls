public with sharing class invoiceTriggerHandler {

    public static void applySharing(List<Invoice__c> triggernew){

        //Get opp ids for applicable invoices
        Set<Id> oppIds = new Set<Id>();
        for(Invoice__c inv : triggernew){
            oppIds.add(inv.Opportunity__c);
        }
        //Query Opportunity object and build map of Oppty Owners
        Map<Id,Id> ownerIds = new Map<Id,Id>();
        for (Opportunity o : [SELECT Id, OwnerId FROM Opportunity WHERE Id IN :oppIds]){
            ownerIds.put(o.Id,o.OwnerId);
        }
        //OPtionally grab any group ids
        //Get GRoupID from GRoup object
        Group SVPGroup = [SELECT ID,DeveloperName FROM Group WHERE DeveloperName = 'SVPCustomerServiceSupportA' LIMIT 1];

        List<Invoice__Share> newShares = new List<Invoice__Share>();
        for (Invoice__c inv : triggernew){
            Invoice__Share ownerShare = new Invoice__Share();
                ownerShare.ParentId = inv.Id;
                ownerShare.UserOrGroupId = ownerIds.get(inv.Opportunity__c);
                ownerShare.AccessLevel = 'Read';
                ownerShare.RowCause = Schema.Invoice__Share.RowCause.Opportunity_Owner__c;
            newShares.add(ownerShare);
        }
        insert newShares;
    }
}