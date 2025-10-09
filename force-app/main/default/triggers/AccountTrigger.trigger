trigger AccountTrigger on Account (before insert, before delete) {
    AccountHandler.accProfileAdmin(Trigger.old);
}