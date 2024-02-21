public with sharing class dxSample {
    public dxSample() {
		System.Debug('This is inside the constructor method');
    }

//Need a method to pull in all the Accounts in California

/*For US-329 Apply correct tax for state level 
- Jeremy White - 2/5/24
*/
    public List<Account> getStateAccounts(String state){
      
      Integer check = 1;
      System.Debug('Check Integer: '+check);
      // Pulls in the specified State in order to make sure the correct tax calculations are applied
      List<Account> accList = [SELECT ID,Name FROM Account WHERE BillingState = :state];
      System.Debug('****Account List*****');
      System.Debug(accList);

      Check ++;
      System.Debug('Check Integer: '+check);



      //Do something with them....
 return accList;

    }

    public Boolean checkSomething(){

      List<Account> caAccounts = getStateAccounts('CA');
      List<Account> txAccounts = getStateAccounts('TX');

      return true;
    }
}