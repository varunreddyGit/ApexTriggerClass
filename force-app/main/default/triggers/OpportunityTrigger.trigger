trigger OpportunityTrigger on Opportunity (before insert) {
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