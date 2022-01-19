@isTest
private class functionsOfOrderApp_Test {
    @isTest static void orderTotalFieldsTest() {
        
        // Create Test Account for recId
        Account testAcc = new Account(
            Name = 'Test Account');
        
        insert testAcc;

        System.assertEquals(testAcc.Name, 'Test Account');

        //Test Name of Order__c
        Order__c testOrder = new Order__c(
            Name = 'Test Order',
            AccountId__c = testAcc.Id);
        String testOrderName ='Test Order Name';

        // Create 10 Product__c 
        List<Product_c__c> products = new List<Product_c__c>();
		for(Integer i = 1; i <= 10; i++) {
			Product_c__c prod = new Product_c__c();
			prod.Name = 'Test Product ' + i;
			prod.Description__c = 'Test Description ' + i;
			prod.Type__c = 'Type 1';
			prod.Family__c = 'Family 1';
			prod.Image__c = 'https://www.apexhours.com/apex-test-class-best-practices/';
			prod.Price__c = i;
            products.add(prod);
		}

      
        try{
            Test.startTest();
            functionsOfOrderApp.setOrderList(products,testOrderName,testAcc.Id);
            Test.stopTest();
        } catch(Exception e){
            
        }

    }

    @isTest static void getAccountDataTest() {
        Account acc = new Account( Name='Test Name' );
        insert acc;
        List<Account> listAcc = new List<Account>();
        listAcc.add(acc);
        System.assertEquals(listAcc, functionsOfOrderApp.getAccountData(acc.Id), 'it is not same account');
    }

    @isTest static void saveProductRecordTest() {
        Product_c__c prod = new Product_c__c();
        System.assertEquals(prod, functionsOfOrderApp.saveProductRecord(prod), 'it is not same product');
        Product_c__c pro;
        System.assertEquals(pro, functionsOfOrderApp.saveProductRecord(prod), 'it is not same product');
    }

    @isTest static void getAllProductTest() {
        List<Product_c__c> listProd = [
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
        System.assertEquals(listProd, functionsOfOrderApp.getAllProduct(), 'It is not same list');
    }

    @isTest static void getUserDetailsTest() {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u1 = new User(Alias = 'fromUser', Email='standarduser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='newuserjoni@testorg.com');
        insert u1;
        System.assertEquals(u1, functionsOfOrderApp.getUserDetails(u1.Id), 'It is not same user');
    }

    @isTest static void searchProductTest() {
         
        List<String> search = new List<String>();
        List<String> typeTerm = new List<String>();
        List<String> familyTerm = new List<String>();
        List<Product_c__c> lstProd= new List<Product_c__c>();
        for(Integer i=1 ;i <3;i++) {
            Product_c__c prod = new Product_c__c();
            prod.Name ='Test Name'+i;
            prod.Type__c = 'Type '+i;
            prod.Family__c = 'Family '+i;
            lstProd.add(prod);
            search.add(prod.Name);
            typeTerm.add(prod.Type__c);
            familyTerm.add(prod.Family__c);
        }

        insert lstProd;

        try{
            Test.startTest();
            for(String a : search){
                for(String b : typeTerm){
                    for(String c : familyTerm){
                        System.assertEquals(lstProd,functionsOfOrderApp.searchProduct(a,b,c),'not equal lists');
                    }
                }
            }
            
            Test.stopTest();
        } catch(Exception e){
            
        }

    }
}

