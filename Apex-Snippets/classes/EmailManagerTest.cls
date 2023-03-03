/*******************************************************************************************
* @Author: David Sullivan
* @CreatedDate: 3/2/23
* @CreationDescription: Test class for "EmailManager" class
/*******************************************************************************************
* @LastModifiedBy: David Sullivan
* @LastModifiedDate: MM/DD/YYYY
* @ModificationDescription: N/A
*******************************************************************************************/
@IsTest
private class EmailManagerTest {
    @IsTest
    static void sendEmailTest() {
        /* Reserve email capacity for the current Apex transaction to ensure
        that we won't exceed our daily email limits.*/
        Messaging.reserveSingleEmailCapacity(2);

        // Create email messaging object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // String array to hold to email addresses
        String[] toAddresses = new String[] {'dave4eva@icloud.com'};

        // Set email fields
        mail.setToAddresses(toAddresses);
        mail.setSubject('Speaker Confirmation');
        mail.setPlainTextBody('Thank you for your registration for Introduction to Apex');
        mail.setSenderDisplayName('Developer Org #2');
        mail.setUseSignature(true);


        // Call the sendMail method
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});

        // Create 1 email session record
        Session__c session = new Session__c(Name = 'Introduction to Apex');
        insert session;

        // Run test
        Test.startTest();
        EmailManager.sendMail('dave4eva@icloud.com',
                                  'Speaker Confirmation',
                                    'Thank you for your registration for Introduction to Apex'
        );

        // Get one session record from org
        Session__c fetchOneSession = [SELECT Name FROM Session__c LIMIT 1];

        Test.stopTest();

        // Check results
        System.assertEquals('Introduction to Apex', fetchOneSession.Name);
    }
}
