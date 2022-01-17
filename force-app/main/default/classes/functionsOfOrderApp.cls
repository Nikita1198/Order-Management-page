public with sharing class functionsOfOrderApp {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountData(String value) {
        return [
            SELECT Name, AccountNumber
            FROM Account
            WHERE Id = :value
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Product_c__c saveProductRecord(Product_c__c obj){
        try{
            System.debug(obj);
            insert obj;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
        return obj;
    }

    @AuraEnabled(Cacheable=true)
    public static Product_c__c[] getAllProduct() {
        return [
            SELECT
                Id,
                Name, 
                Image__c, 
                Type__c,
                Family__c,
                Description__c,
                Price__c
            FROM Product_c__c
            ORDER BY Name
            LIMIT 50
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static Product_c__c[] searchProduct(String searchTerm) {
        // Return all bears when no search term
        searchTerm = searchTerm.trim();
        if (searchTerm == '') {
            return getAllProduct();
        }
        // Prepare query paramters
        searchTerm = '%' + searchTerm + '%';
        // Execute search query
        return [
            SELECT
                Id,
                Name, 
                Image__c, 
                Type__c,
                Family__c,
                Description__c,
                Price__c
            FROM Product_c__c
            WHERE Name LIKE :searchTerm
            ORDER BY Name
            LIMIT 50
        ];
    }

}
