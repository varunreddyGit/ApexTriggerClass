public class OpportunityHandler {
//Account records should have a field named ‘Recent Opportunity Amount’. It should contain 
//the opportunity amount of the latest created opportunity on account.

    public static void oppAmountToAcc(Set<Id> accountIds) {
    if(accountIds.isEmpty()) return;
    //Map to store Account Id to Latest Opportunity Amount
    Map<Id, Decimal> accIdToOppAmount = new Map<Id, Decimal>();
    //Query the latest opportunity amount for each account
    List<Opportunity> oppList = [SELECT Id, AccountId, Amount, CreatedDate FROM 
                 Opportunity WHERE AccountId IN : accountIds ORDER BY CreatedDate DESC];
    
    //Track latest account
    for(Opportunity opp : oppList){
        if(!accIdToOppAmount.containsKey(opp.AccountId)){
            accIdToOppAmount.put(opp.AccountId, opp.Amount);
        }
    }
    //Prepare Accounts for update
    List<Account> accountToUpdate = new List<Account>();
    for(Id accId : accIdToOppAmount.keySet()){
        Account acc = new Account(Id = accId, Recent_Opportunity_Amount__c = accIdToOppAmount.get(accId));
        accountToUpdate.add(acc);
    } 
    if(!accountToUpdate.isEmpty()){
        update accountToUpdate;
    }
    }
 }
