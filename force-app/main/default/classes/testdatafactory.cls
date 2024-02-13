@isTest
public class testdatafactory {

    static Account createValidAccount(String aName){
        Account a = new Account();
        a.Name = aName;
        return a;
    }

    static Opportunity createValidOpportunity(Id accId,
                                              Date cDate,
                                              Decimal amount,
                                              String type,
                                              String stage){
        Opportunity o = new Opportunity();
        o.Name = 'test Opp';
        o.Amount = amount;
        o.Type = type;
        o.StageName = stage;
        o.CloseDate = cDate;
        o.AccountId = accId;
        return o;
    }

    public static Account createSingleAccWithOpp(){
        Account a = createValidAccount('Test Account');
        insert a;

        Opportunity o = createValidOpportunity(a.Id,
                                               Date.today(),
                                               3456,
                                               'New Customer',
                                               'Prospecting');
       insert o;
       return a;
    }
}