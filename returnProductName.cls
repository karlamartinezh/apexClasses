public with sharing class returnProductName {
    @AuraEnabled(Cacheable=true)
    public static string returnProductName(string prodId) {
       
         string name = [Select id, name from Product2 where id =: prodId].Name;
        return name;
    }
}
