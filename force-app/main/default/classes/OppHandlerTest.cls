@isTest
private class OppHandlerTest {

   
    @isTest
    static void applyNamingConventionTest() {
        testdatafactory.createSingleAccWithOpp();
        //Part Three - Check the results are as expected
        Opportunity updatedOpp = [SELECT Id, Name FROM Opportunity LIMIT 1];
        System.assertEquals('Test - New Customer - 2/2024', updatedOpp.Name, 'Naming convention failed to apply as expected');
    }

    @isTest
    static void applyNamingConventionAfterAccountChangeTest() {
     //  Account testAccount = testdatafactory.createSingleAccWithOpp();
     testdatafactory.createSingleAccWithOpp(); //How many DML?
     Account testAccount = [SELECT Id,Name FROM Account LIMIT 1];

          //Part Two - Actual Test
          Test.startTest();
          testAccount.Name = 'Changed';
          update testAccount;
          Test.stopTest();

        //Part Three - Check the results are as expected
        Opportunity updatedOpp = [SELECT Id, Name FROM Opportunity LIMIT 1];
        System.assertEquals('Changed - New Customer - 2/2024', updatedOpp.Name, 'Naming convention failed to apply as expected');
    }
}