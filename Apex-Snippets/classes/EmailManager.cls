/*******************************************************************************************
* @Author: David Sullivan
* @CreatedDate: 3/2/23
* @CreationDescription: Apex class to send email to the speaker enrolled to a session
* @Credits: https://mytutorialrack.teachable.com/courses/248511/lectures/3875801
/*******************************************************************************************
* @LastModifiedBy: David Sullivan
* @LastModifiedDate: MM/DD/YYYY
* @ModificationDescription: N/A
*******************************************************************************************/
public class EmailManager {
    public static void sendMail(String emailAddress, String subject, String body) {

        /* Reserve email capacity for the current Apex transaction to ensure
        that we won't exceed our daily email limits.*/
        Messaging.reserveSingleEmailCapacity(2);

        // Create email messaging object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // String array to hold to email addresses
        String[] toAddresses = new String[] {emailAddress};

        // Set email fields
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        mail.setSenderDisplayName('Developer Org #2');
        mail.setUseSignature(true);


        // Call the sendMail method
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}