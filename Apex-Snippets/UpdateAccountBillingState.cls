/*******************************************************************************************
* @Author: David Sullivan
* @CreatedDate: 2/28/23
* @CreationDescription: Update account billing state for all the accounts using queueable apex
* @Credits: https://www.youtube.com/watch?v=55F_dv9ig9s&t=84s
/*******************************************************************************************
* @LastModifiedBy: David Sullivan
* @LastModifiedDate: MM/DD/YYYY
* @ModificationDescription: N/A
*******************************************************************************************/
public class UpdateAccountBillingState implements Queueable{

    private List<Account> acctList;
    private String state;

    public UpdateAccountBillingState(List<Account>accounts, String stateAbb) {
        this.acctList = accounts;
        this.state = stateAbb;
    }
    public void execute(QueueableContext context) {
        for (Account acct : acctList) {
            acct.BillingState = 'CA';
            acct.Description = 'This account was last updated by ' + UserInfo.getName();
        }
        update acctList;
    }
}
