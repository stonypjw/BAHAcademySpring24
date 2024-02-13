trigger badPracticeTrigger2 on Lead (before insert) {

    List<Lead> newLeads = new List<Lead>();
    
    for(Lead l : trigger.new){
        l.LeadSource = 'Web';
    }
    
   // insert newLeads;
}