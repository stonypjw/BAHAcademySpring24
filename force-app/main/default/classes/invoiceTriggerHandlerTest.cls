@isTest
private class invoiceTriggerHandlerTest {

    @isTest
    private static void applySharingOnInsertTest(){
        //Ingredients need for Sharing Test
        //Opportunity - with an Owner (opp gets set to Close Won)

        testdatafactory.createSingleAccWithOpp();
        Opportunity opp = [SELECT Id, OwnerId FROM Opportunity LIMIT 1];
        //Invoice__c linked to that Opportunity

        //Test is the insert or update of invoice record
        Test.startTest();
        opp.StageName = 'Closed Won';
        update opp;
        Test.stopTest();
        
        Invoice__c newInv = [SELECT ID,Amount__c,Opportunity__c,Opportunity__r.OwnerId,Account__c FROM Invoice__c LIMIT 1];
        System.Debug(newInv);
        System.Debug('OppOwnerId='+newInv.Opportunity__r.OwnerId);
        //Check with a query to Invoice__Share to check results
        Boolean parentMatch,userMatch,causeMatch,accessMatch;
        for(Invoice__Share is : [SELECT ID,ParentId,UserOrGroupId,RowCause,AccessLevel FROM Invoice__Share]){
            System.Debug(is);
            if(is.ParentId == newInv.Id){
                if(is.UserOrGroupId == opp.OwnerId){
                    if(is.RowCause == 'Opportunity_Owner__c'){
                          causeMatch = true;
                          userMatch = true;
                          parentMatch = true;
                        if(is.AccessLevel == 'Read'){
                            accessMatch = true;
                        }
                    }
                }
            }
        }
        System.assertEquals(true, parentMatch, 'Share record not connected to expected parent');
        System.assertEquals(true, userMatch, 'Share record not connected to expected user');
        System.assertEquals(true, causeMatch, 'Share record not designated to correct cause');
        System.assertEquals(true, accessMatch, 'Share record provisioned with correct access level');
                                     
    }

    @isTest
    private static void applySharingOnUpdateTest(){
        //Ingredients need for Sharing Test
        //Opportunity - with an Owner (opp gets set to Close Won)

        testdatafactory.createSingleAccWithOpp();
        Opportunity opp = [SELECT Id, OwnerId FROM Opportunity LIMIT 1];
        //Invoice__c linked to that Opportunity
        opp.StageName = 'Closed Won';
        update opp;
        //Test is the insert or update of invoice record
        Invoice__c newInv = [SELECT ID,Amount__c,Opportunity__c,Opportunity__r.OwnerId,Account__c FROM Invoice__c LIMIT 1];
        Test.startTest();
        newInv.Amount__c = 643789;
        update newInv;
        Test.stopTest();
        
      
        System.Debug(newInv);
        System.Debug('OppOwnerId='+newInv.Opportunity__r.OwnerId);
        //Check with a query to Invoice__Share to check results
        Boolean parentMatch,userMatch,causeMatch,accessMatch;
        for(Invoice__Share is : [SELECT ID,ParentId,UserOrGroupId,RowCause,AccessLevel FROM Invoice__Share]){
            System.Debug(is);
            if(is.ParentId == newInv.Id){
                if(is.UserOrGroupId == opp.OwnerId){
                    if(is.RowCause == 'Opportunity_Owner__c'){
                          causeMatch = true;
                          userMatch = true;
                          parentMatch = true;
                        if(is.AccessLevel == 'Read'){
                            accessMatch = true;
                        }
                    }
                }
            }
        }
        System.assertEquals(true, parentMatch, 'Share record not connected to expected parent');
        System.assertEquals(true, userMatch, 'Share record not connected to expected user');
        System.assertEquals(true, causeMatch, 'Share record not designated to correct cause');
        System.assertEquals(true, accessMatch, 'Share record provisioned with correct access level');
                                     
    }
}