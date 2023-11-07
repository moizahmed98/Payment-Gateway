public class MakePayment {
    @AuraEnabled(cacheable=true)
    public static List<logicpayment__Payment__c> getCreditCards(Id accountId) {
        // Query the custom Payment__c object to retrieve related credit card records
        List<logicpayment__Payment__c> creditCards = [SELECT Id, Name,logicpayment__Card__c,logicpayment__Type__c,logicpayment__Payment_Id__c,logicpayment__Customer_Payment_Id__c,logicpayment__Reference__c /* Add other fields you need */
                                       FROM logicpayment__Payment__c
                                       WHERE logicpayment__Account__c = :accountId];
                                       System.debug('this is the returned result : '+creditCards);
        return creditCards;
    }

}