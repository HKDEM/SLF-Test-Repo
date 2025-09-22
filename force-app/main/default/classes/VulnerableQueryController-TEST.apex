public with sharing class VulnerableQueryController {

    // This method is vulnerable to SOQL injection because it directly
    // concatenates a user-supplied string into a SOQL query.
    @AuraEnabled
    public static List<Contact> searchContacts(String searchName) {
        String query = 'SELECT Id, Name, Email FROM Contact WHERE Name LIKE \'%' + searchName + '%\' LIMIT 10';
        
        // The analyzer will flag this as a potential security issue.
        return Database.query(query);
    }
}
 
