trigger masterInterviewerTrigger on Interviewer__c (before insert, after insert,
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
        interviewerTriggerHandler.createReviewRecordOnInterviewerInsert(trigger.new);
    }
    if(trigger.isUpdate){  
         
    }
    if(trigger.isDelete){       
    }
    if(trigger.isUnDelete){      
    }
}
                                         }