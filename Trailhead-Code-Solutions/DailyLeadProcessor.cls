/*******************************************************************************************
* @Author: David Sullivan
* @CreatedDate: 3/1/23
* @CreationDescription: Apex class that implements the Schedulable interface to
 *                      update Lead records with a specific LeadSource.
* @Credits: https://sforce.co/3ICDWXK
/*******************************************************************************************
* @LastModifiedBy: David Sullivan
* @LastModifiedDate: MM/DD/YYYY
* @ModificationDescription: N/A
*******************************************************************************************/
public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext context) {

        // Query 200 leads with with blank LeadSource field
        List<Lead> leadsList = [SELECT LeadSource FROM Lead WHERE LeadSource = NULL LIMIT 200];

        // Updated the LeadSource on 200 leads with value of 'Dreamforce'
        for (Lead ld : leadsList) {
            ld.LeadSource = 'Dreamforce';
        }
        update leadsList;
    }
}