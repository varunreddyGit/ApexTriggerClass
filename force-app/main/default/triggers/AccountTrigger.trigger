trigger AccountTrigger on Account (before insert, before update, after insert) {
    AccountHandler.accProfileAdmin(Trigger.old);
    if(Trigger.isBefore && Trigger.isInsert){
        AccountHandler.populateAddress(Trigger.new);
        AccountHandler.accToContact(Trigger.new);
    }
}