trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
    AccountHandler.accProfileAdmin(Trigger.old);
    if(trigger.isAfter && trigger.isInsert){
        AccountHandler.createMulCons(Trigger.new);
    }
    if(trigger.isBefore && trigger.isInsert){
        AccountHandler.populateAddress(Trigger.new);
        AccountHandler.accToContact(Trigger.new);
    }
}