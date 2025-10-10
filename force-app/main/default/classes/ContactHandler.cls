public class ContactHandler {
    public static void sendEmailToContacts(List<Contact> newContacts) {
        List<Messaging.singleEmailMessage> emails = new List<Messaging.singleEmailMessage>();
        EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName = 'New_Contact_Creation_Template' LIMIT 1];
        for(Contact con : newContacts){
            if(con.Email != null){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setTargetObjectId(con.Id);     //recipient = contact, tells Salesforce which Contact the email should be sent to.  
                mail.setTemplateId(template.Id);    //use our email template
                mail.setSaveAsActivity(false);      //prevents logging an activity for the email.
                emails.add(mail);   //send the emails
            }
        }
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }
}