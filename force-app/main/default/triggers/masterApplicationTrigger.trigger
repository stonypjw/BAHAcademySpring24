trigger masterApplicationTrigger on Application__c (before insert, after insert,
                                         before update, after update,
                                         before delete, after delete,
                                         after undelete) {
if(trigger.isBefore){
    if(trigger.isInsert){
      
    }
    if(trigger.isUpdate){   
       
    }
    if(trigger.isDelete){     
    }
}

if(trigger.isAfter){
    if(trigger.isInsert){
        
    }
    if(trigger.isUpdate){  
         applicationTriggerHandler.createReviewRecordOnApplicationUpdate(trigger.new, trigger.oldMap);
    }
    if(trigger.isDelete){       
    }
    if(trigger.isUnDelete){      
    }
}
                                         }