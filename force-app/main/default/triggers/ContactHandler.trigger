trigger ContactHandler on Contact (before insert, after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        ContactHandler.sendEmailToContacts(Trigger.new);
    }
}