trigger updateParentAccountWithOpportunityName on Opportunity (after insert) {

    // Create a Map from Account Ids to Opportunities.
    Map<Id, Opportunity> accountIdOpportunityMap = new Map<Id, Opportunity>();

    for(Opportunity o : Trigger.new){
        accountIdOpportunityMap.put(o.AccountId, o);
    }
    
    // Create a list of Accounts to Update.
    List<Account> accounts = new List<Account>();

    for(Account a : [SELECT Id, Most_Rcntly_Crtd_Opty_Name__c 
                     FROM Account 
                     WHERE Id IN :accountIdOpportunityMap.keySet()]){
        a.Most_Rcntly_Crtd_Opty_Name__c = 
                               ((Opportunity) accountIdOpportunityMap.get(a.Id)).Name;
        accounts.add(a);
    }
    
    update accounts;    
}