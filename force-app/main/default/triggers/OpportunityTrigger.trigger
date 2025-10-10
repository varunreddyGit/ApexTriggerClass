trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    //(before insert){
    Set<Id> accIds = new Set<Id>();
    for(Opportunity opp : Trigger.new){
        if(opp.AccountId != null){
            accIds.add(opp.AccountId);
        }
    }
    if(!accIds.isEmpty()){
        OpportunityHandler.oppAmountToAcc(accIds);
    }
    }
// OpportunityHandler.oppAccAmountUpdate(Trigger.isInsert, Trigger.isUpdate, Trigger.isDelete, Trigger.isUndelete);