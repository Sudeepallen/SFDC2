@isTest
private class UpdateParentAccountWithOpptyNameTest{
  static testMethod void testUpdateParentAccount(){     

    // Set up the Account record.
    Account a = new Account(Name='Test Account');
    insert a;

    // Verify that the initial state is as expected.
    a = [SELECT Name, Most_Rcntly_Crtd_Opty_Name__c 
         FROM Account 
         WHERE Id = :a.Id];
    System.assertEquals(null, a.Most_Rcntly_Crtd_Opty_Name__c);

    // Set up the Opportunity record.
    String opportunityName = 'My Opportunity';
    Opportunity o = new Opportunity(AccountId=a.Id, Name=opportunityName, 
                                    StageName='Prospecting', CloseDate=Date.today(),Zip__c='25098');

    // Cause the Trigger to execute.
    insert o;

    // Verify that the results are as expected.
    a = [SELECT Name, Most_Rcntly_Crtd_Opty_Name__c 
         FROM Account 
         WHERE Id = :a.Id];
    System.assertEquals(opportunityName, a.Most_Rcntly_Crtd_Opty_Name__c);
  }
}