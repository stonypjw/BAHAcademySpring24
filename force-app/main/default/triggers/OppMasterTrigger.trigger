trigger OppMasterTrigger on Opportunity (before insert, after insert,
                                         before update, after update,
                                         before delete, after delete,
                                         after undelete) {
if(trigger.isBefore){
    if(trigger.isInsert){
       OppHandler.applyNamingConvention(trigger.new);
    }
    if(trigger.isUpdate){   
        OppHandler.applyNamingConvention(trigger.new);
    }
    if(trigger.isDelete){     
    }
}

if(trigger.isAfter){
    if(trigger.isInsert){
        OppHandler.createInvoiceFromOpportunity(trigger.new);
    }
    if(trigger.isUpdate){  
        OppHandler.createInvoiceFromOpportunity(trigger.new,trigger.oldmap);     
    }
    if(trigger.isDelete){       
    }
    if(trigger.isUnDelete){      
    }
}

}
