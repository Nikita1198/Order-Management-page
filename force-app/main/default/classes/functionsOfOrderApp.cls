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
        ];
    }

    @AuraEnabled(Cacheable=true)
    public static Product_c__c[] searchProduct(String searchTerm, String typeTerm, String familyTerm) {
        
        searchTerm = searchTerm.trim();

         // Prepare query paramters
         searchTerm = '%' + searchTerm + '%';
         // Execute search query

        List<Product_c__c> prod = new List<Product_c__c>();

        if (searchTerm == '' && typeTerm == '' && familyTerm == '') {
            return getAllProduct();
        }else if (typeTerm == '' && familyTerm == '') {
            prod = [
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
        } else if (searchTerm != '' && typeTerm == '' ) {
            prod = [
            SELECT
                Id,
                Name, 
                Image__c, 
                Type__c,
                Family__c,
                Description__c,
                Price__c
            FROM Product_c__c
            WHERE Family__c = :familyTerm
            AND Name LIKE :searchTerm
            ORDER BY Name
            LIMIT 50
        ];
        } else if (searchTerm != '' && familyTerm == '' ) {
            prod = [
            SELECT
                Id,
                Name, 
                Image__c, 
                Type__c,
                Family__c,
                Description__c,
                Price__c
            FROM Product_c__c
            WHERE Type__c = :typeTerm
            AND Name LIKE :searchTerm
            ORDER BY Name
            LIMIT 50
        ];
        } else if (searchTerm != '' && typeTerm != '' && familyTerm != '') {
            prod =  [
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
            AND Family__c LIKE :familyTerm
            AND Type__c LIKE :typeTerm
            ORDER BY Name
            LIMIT 50
        ];
        }
        return prod;
    }

}
