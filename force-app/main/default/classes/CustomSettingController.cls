public with sharing class CustomSettingController {
    @AuraEnabled(cacheable=true)
    public static List<String> getCustomSettingDataChecker() {
        List<String> customSettingNames = new List<String>();
        try
        {
            

            // Check and add custom setting names if they are not null or empty
            if (logicpayment__GlobalPayment_CustomSetting__c.getInstance() != null && !String.isBlank(logicpayment__GlobalPayment_CustomSetting__c.getInstance().logicpayment__App_Key__c)) {
                customSettingNames.add('Global Payments');
            }
    
            if (logicpayment__AuthorizeNet_CustomSettings__c.getInstance() != null && !String.isBlank(logicpayment__AuthorizeNet_CustomSettings__c.getInstance().logicpayment__API_Login_Key__c)) {
                customSettingNames.add('Authorize.net');
            }
    
            if (logicpayment__stripe_CustomSetting__c.getInstance() != null && !String.isBlank(logicpayment__stripe_CustomSetting__c.getInstance().logicpayment__API_Secret_Key__c)) {
                customSettingNames.add('Stripe');
            }
            system.debug(customSettingNames);
        }
        catch(exception e)
        {
            system.debug(e);
        }
        
        return customSettingNames;
    }
}