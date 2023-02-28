/*******************************************************************************************
* @Author: David Sullivan
* @CreatedDate: 2/28/23
* @CreationDescription: Create a Queueable Apex class that inserts the same Contact
                        for each Account for a specific state.
/*******************************************************************************************
* @LastModifiedBy: David Sullivan
* @LastModifiedDate: MM/DD/YYYY
* @ModificationDescription: 
*******************************************************************************************/
public without sharing class AddPrimaryContact implements Queueable{

    private Contact con;
    private String state;

    // Constructor that accepts (2) args of contact & state
    public AddPrimaryContact(Contact inputContact, String inputState) {
        this.con = inputContact;
        this.state = inputState;
    }

    public void execute(QueueableContext context) {
        /* Query for a maximum of 200 accounts with the BillingState
       specified by inputState in constructor */
        List<Account> accountList = [SELECT BillingState
                                     FROM Account
                                     WHERE BillingState = :state
                                     LIMIT 200];
        // List to hold contacts
        List<Contact> contacts = new List<Contact>();

        for (Account acct : accountList) {
            // Clone the contact passed into the constructor 200x
            Contact contactClone = con.clone();
            // Associate each contact with an account
            con.AccountId = acct.Id;
            // Add each contact to contacts list
            contacts.add(contactClone);
        }
        insert contacts;
    }
}