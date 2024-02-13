trigger updateOpportunityFromAccount on Account (after update) {

    //Part One - Gather Ingredients
    //Part Two - Do the work
    //If the change on the account was a change to the Name then we should intiate an update to the opp.
    //trigger.new will tell us which accounts have been changed
    //trigger.oldMap will help us compare the value of the account name before and after
    Set<Id> accId = new Set<Id>();
    for(Account a : trigger.new){
        if(a.Name != trigger.oldMap.get(a.Id).Name){
            accId.add(a.Id);
        }
    }

    //pArt Three - Submit work to database
    List<Opportunity> oppsToUpdate = [SELECT ID FROM Opportunity WHERE AccountId IN :accId];
    List<Database.SaveResult> srlist = Database.update(oppsToUpdate,false);
    for(Database.SaveResult sr : srList){
        System.Debug('Success?:'+sr.isSuccess());
    }
}