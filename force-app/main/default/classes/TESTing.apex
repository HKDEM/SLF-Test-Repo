public with sharing class VulnerableAccountSearch {
    
    @AuraEnabled
    public static List<Account> searchAccounts(String accountName) {
        
        // This query is vulnerable to SOQL Injection!
        // The user input 'accountName' is directly concatenated into the query string.
        String query = 'SELECT Id, Name FROM Account WHERE Name LIKE \'%' + accountName + '%\'';
        
        // The Database.query() method executes the dynamically constructed string.
        try {
            return Database.query(query);
        } catch (QueryException e) {
            // Log the exception, but a malicious user's crafted input
            // might not even trigger an error.
            System.debug('Query Exception: ' + e.getMessage());
            return null;
        }
    }
}
