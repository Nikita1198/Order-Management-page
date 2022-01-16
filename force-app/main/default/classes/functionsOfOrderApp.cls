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
}
