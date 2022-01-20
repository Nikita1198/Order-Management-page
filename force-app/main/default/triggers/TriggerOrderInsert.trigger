trigger TriggerOrderInsert on OrderItem__c (after insert, after update) {

        List<OrderItem__c> orderItem = [SELECT Id, Price__c, Quantity__c, OrderId__c 
                                    FROM OrderItem__c 
                                    WHERE Id = : Trigger.New];
        
        OrderItem__c test = [SELECT OrderId__c
                            FROM OrderItem__c 
                            WHERE Id = : Trigger.New
                            Limit 1];
        
        Order__c order = [SELECT Id, TotalProductCount__c, TotalPrice__c 
                          FROM Order__c
                          WHERE Id = :test.OrderId__c
                          Limit 1] ;
    
       List<OrderItem__c> orderItemOld = [SELECT Id, Price__c, Quantity__c, OrderId__c 
                                    FROM OrderItem__c 
                                    WHERE OrderId__c = :order.Id 
                                    AND Id != :Trigger.New];   
        
    
        Double totalPrice = 0;
        Double totalQuantity = 0;
    
        for(OrderItem__c ord : orderItem) {
            totalPrice += ord.Price__c;
            totalQuantity += ord.Quantity__c;
        }
        system.debug( order.TotalProductCount__c);
        system.debug( order.TotalPrice__c);
        
    
        if(orderItemOld.size() != 0 && orderItemOld.size() != null){
            for(OrderItem__c ord : orderItemOld) {
                totalPrice += ord.Price__c;
                totalQuantity += ord.Quantity__c;
            }  
        }
    
        order.TotalProductCount__c = totalQuantity;
        order.TotalPrice__c = totalPrice; 
        
        
        try {
            system.debug( order.TotalProductCount__c);
            system.debug( order.TotalPrice__c);
            update order;
        } catch (DmlException e){
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    
    
    }