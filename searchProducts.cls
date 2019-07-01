public with sharing class searchProducts {

@AuraEnabled(Cacheable=true)
    public static List<ProductWrapper> getAllProducts(id lookupId) {
        system.debug(lookupId);
        List<ProductWrapper> prod2return = new List<ProductWrapper>();

        if(lookupId != null){
        
        List<PMO_Project_Products__c>  prods = [SELECT Id,Name,PMO_Project__c,PMO_Include__c 
            FROM PMO_Project_Products__c 
            WHERE PMO_Project__c =: lookupId
            ORDER BY Name ASC LIMIT 50];

        for(PMO_Project_Products__c p : prods){
            ProductWrapper pwrapp = new ProductWrapper();

            pwrapp.include = p.PMO_Include__c;
            pwrapp.projectName = p.Name;
            pwrapp.id = p.id;
            prod2return.add(pwrapp);
        } 

        for(product2 p: [Select Id,Name,Family FROM Product2  WHERE Family like '%CPQ%' AND Id NOT IN (SELECT PMO_Product__c FROM PMO_Project_Products__c WHERE PMO_Project__c =: lookupId) Order By Name ASC LIMIT 1000]){
                ProductWrapper pwrapp2 = new ProductWrapper();
                pwrapp2.include = false;
                pwrapp2.projectName = p.Name;
                pwrapp2.id = p.id;
                prod2return.add(pwrapp2);
        }

    } // end IF

    
        return prod2return;
    }

    public Class ProductWrapper{
       @AuraEnabled
       public boolean include{get;set;}
       @AuraEnabled
       public String projectName{get;set;}
       @AuraEnabled
       public String id{get;set;} 
       
       }

}
