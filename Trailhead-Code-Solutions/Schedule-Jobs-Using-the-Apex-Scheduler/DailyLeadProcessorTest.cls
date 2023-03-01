/*******************************************************************************************
* @Author: David Sullivan
* @CreatedDate: 3/1/23
* @CreationDescription: Test class for DailyLeadProcessor apex class
* @Credits: https://sforce.co/3ICDWXK
/*******************************************************************************************
* @LastModifiedBy: David Sullivan
* @LastModifiedDate: MM/DD/YYYY
* @ModificationDescription: N/A
*******************************************************************************************/
@IsTest
private class DailyLeadProcessorTest {

    // CRON Expression that runs the job at a specified time
    private static String CRON_EXP = '0 30 15 * * ?';

    @IsTest
    static void create200Leads(){
        List<Lead> leadsList = new List<Lead>();

        // Created 200 leads
        for (Integer i = 0; i < 200; i++) {
            Lead ld = new Lead(LastName = 'DailyLeadProcessorTest ' + i,
                               Company = 'DailyLeadProcessor Company ' + i,
                               Status = 'Open - Not Contacted');
            leadsList.add(ld);
        }
        insert leadsList;

        // Perform the test
        Test.startTest();
        String jobId = System.schedule('Update LeadSource', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();

        // Check results
        List<Lead> queryLeads = [SELECT Company
                                 FROM Lead
                                 WHERE Company
                                         LIKE 'DailyLeadProcessor Company %'];
        System.assertEquals(200, queryLeads.size());
    }
}