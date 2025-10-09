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
}