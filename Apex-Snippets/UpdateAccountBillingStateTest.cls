/*******************************************************************************************
* @Author: David Sullivan
* @CreatedDate: 2/28/23
* @CreationDescription:  Test class for UpdateAccountBillingState class
* @Credits: https://www.youtube.com/watch?v=55F_dv9ig9s&t=84s
/*******************************************************************************************
* @LastModifiedBy: David Sullivan
* @LastModifiedDate: MM/DD/YYYY
* @ModificationDescription: 
*******************************************************************************************/
@IsTest
private class UpdateAccountBillingStateTest {

    @TestSetup
    static void testCreateAccounts() {
        // List to store accounts
        List<Account> accountList = new List<Account>();

        // Create 100 accounts
        for (Integer i = 0; i < 100; i++) {
            accountList.add(new Account(Name = 'CA Accounts ' + i));
        }
        insert accountList;
    }

    @IsTest
    private static void testUpdateBillingState() {

        List<Account> queryAccounts = [SELECT Name FROM Account WHERE Name LIKE 'CA Accounts %'];

        //Create queueable class instance
        UpdateAccountBillingState runJob = new UpdateAccountBillingState(queryAccounts, 'CA');

        // Run test
        Test.startTest();
        System.enqueueJob(runJob);
        Test.stopTest();

        // Run test
        System.assertEquals(100, queryAccounts.size());
    }
}