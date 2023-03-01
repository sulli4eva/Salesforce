/*******************************************************************************************
* @Author: David Sullivan
* @CreatedDate: 2/28/23
* @CreationDescription:  Test class for "AddPrimaryContact" apex class
  Link to Trailhead Module: https://sforce.co/3mafBkk
/*******************************************************************************************
* @LastModifiedBy: David Sullivan
* @LastModifiedDate: MM/DD/YYYY
* @ModificationDescription: 
*******************************************************************************************/
@IsTest
private class AddPrimaryContactTest {
    @IsTest
    static void testAddPrimaryContact() {

         /* Insert 50 Account records for BillingState 'NY' and 50
         with the BillingState of 'CA' */
        // List to hold CA accounts & contacts
        List<Account> caAccounts = new List<Account>();

        for (Integer i = 0; i < 51; i++) {
            Account acct =  new Account(BillingState = 'CA', Name = 'Test Account' + i);
            caAccounts.add(acct);
        }
        insert caAccounts;

        // List to hold accounts NY accounts
        List<Account> nyAccounts = new List<Account>();

        for (Integer i = 0; i < 50; i++) {
            Account acct =  new Account(BillingState = 'NY', Name = 'Test Account' + i);
            nyAccounts.add(acct);
        }
        insert nyAccounts;

        Contact con = new Contact(FirstName=UserInfo.getFirstName(), LastName=UserInfo.getLastName());
        insert con;

        // Perform the test
        Test.startTest();
        Id jodID = System.enqueueJob(new AddPrimaryContact(con, 'CA'));
        Test.stopTest();

        List<Contact> queryContacts = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'];
        System.assertEquals(50, queryContacts.size());
    }
}