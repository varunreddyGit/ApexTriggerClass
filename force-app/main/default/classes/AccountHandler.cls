public class AccountHandler {
//Write a trigger on Account and check only System Administrator profile users should be able to delete an account.
    public static void accProfileAdmin(List<Account> accList) {
        String profileName = [SELECT Id, Name FROM Profile WHERE Id = :UserInfo.getProfileId()].Name;
        if(profileName != 'System Administrator'){
            for(Account acc : accList){
                acc.addError('Delete account is not allowed');
            }
        }
    }
// Populate Account Billing Address to shipping Address while inserting an Account
    public static void populateAddress(List<Account> accList){
        for(Account acc : accList){
            if(acc.BillingStreet !=null || acc.BillingCity != null || acc.BillingState != null
                                        || acc.BillingPostalCode != null || acc.BillingCountry != null){
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingState = acc.BillingState;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingCountry = acc.BillingCountry;
            }
        }
    }
// Whenever New Account Record is created then needs to create associated Contact Record automatically.
    public static void accToContact(List<Account> accList){
        List<Contact> insertCon = new List<Contact>();
        for(Account acc : acclist){
            Contact  con = new Contact();
            con.FirstName = 'Varun';
            con.LastName = acc.Name;
            con.AccountId = acc.Id;
            insertCon.add(con);
        }   
        if(!insertCon.isEmpty()){
            insert insertCon;
        }
    }
//Creates the number of contacts which are equal to the number which we will enter in the Number of Locations 
//field on the Account Object.
    public static void createMulCons(List<Account> accList){
        List<Contact> conAccount = new List<Contact>();
        for(Account acc : accList){
            if(acc.Number_of_Locations__c != null && acc.Number_of_Locations__c > 0){
                Integer numberOfContacts = Integer.valueOf(acc.Number_of_Locations__c);
                for(Integer i = 1; i <= acc.Number_of_Locations__c; i++){
                    Contact con = new Contact();
                    con.LastName = acc.Name + i;
                    con.AccountId = acc.Id;
                    conAccount.add(con);
                }
            }
        }
        if(!conAccount.isEmpty()){
            insert conAccount;
        }
    }
}