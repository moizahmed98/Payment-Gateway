public  with sharing class AdminAuthenticationController 
//AdminAuthenticationController
{
    //Method to authenticate Authorize.net Merchant account
    @AuraEnabled
    public static AuthNetAdminWrapper authorizeNetAdminAuth(String authorizeNetMerchantName, String authorizeNetApiLoginId, String authorizeNetTransactionKey )
    {

        
        
        try 
        {
            AuthNetAdminWrapper authNetAPIResponse= AuthenticateAuthorizeNetAdmin.authenticateAuthorizeNetAdminAPI(authorizeNetMerchantName, authorizeNetApiLoginId, authorizeNetTransactionKey);
            System.debug('authNetAPIResponse::'+authNetAPIResponse);
            // Check if the authentication with Authorize.Net was successful (result code is 'Ok')
            if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'ok')
            {
                // Retrieve the org-level default Custom Setting record for Authorize.Net
                updateauthNetCustomsetting(authorizeNetMerchantName,authorizeNetApiLoginId,authorizeNetTransactionKey);
                
            }
            // Handle the case where the authentication with Authorize.Net resulted in an error
            else if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'error')
            {

            }
            system.debug('this is the final respoinse :'+authNetAPIResponse );
            return authNetAPIResponse;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
/////////////////////////////////////////////////////////

@AuraEnabled
public static GlobalPayAdminWrapper globalPaymentAdminAuth(String globalPaymentMerchantName, String globalPaymentAppId, String globalPaymentAppKey )
{
    try 
    {
        GlobalPayAdminWrapper globalPaymentAPIResponse= AuthenticateGlobalPaymentAdmin.authenticateGlobalPaymentAdminAPIForAdmin(globalPaymentMerchantName, globalPaymentAppId, globalPaymentAppKey );
        System.debug('globalPaymentAPIResponse::'+globalPaymentAPIResponse);
        // Check if the authentication with Global Payment was successful (result code is 'Ok')
        if(globalPaymentAPIResponse.error_code== null )
        {
            // Retrieve the org-level default Custom Setting record for Global Payment
            updateglobalPaymentCustomsetting(globalPaymentMerchantName,globalPaymentAppId,globalPaymentAppKey);
        }
        // Handle the case where the authentication with Global Payment resulted in an error
        else
        {
            System.debug('Error : '+globalPaymentAPIResponse.error_code);
            System.debug('Error Description : '+globalPaymentAPIResponse.detailed_error_description);
        }
        return globalPaymentAPIResponse;
        
    } 
    catch (Exception e) 
    {
        throw new AuraHandledException(e.getMessage());
    }
}


    
     //Method to authenticate Stripe Merchant account
    @AuraEnabled
    public static StripeAdminWrapper stripeAdminAuth(String stripeMerchantName, String stripeSecretApiKey, String stripePublishableApiKey )
    {
       StripeAdminWrapper stripeAPIResponse= AuthenticateStripeAdmin.authenticateStripeAdminAPI(stripeMerchantName, stripeSecretApiKey);
            System.debug('stripeAPIResponse::      '+stripeAPIResponse);
          // Check if the authentication with Stripe was successful (result code is 'Ok')
        
            if(stripeAPIResponse.error == null  )
            {
                    system.debug('in first if ');
                   
                    if(stripeAPIResponse.Settings.dashboard.display_name == stripeMerchantName)
                    {
                        system.debug('the  display name is correct and the merchant is authenticated');
                        // Retrieve the org-level default Custom Setting record for Stripe
                        updateStripeCustomsetting(stripeMerchantName,stripeSecretApiKey,stripePublishableApiKey);
                    }
                    else if(stripeAPIResponse.Settings.dashboard.display_name != stripeMerchantName)
                    {
                        system.debug('display name is not correct : '+stripeAPIResponse);
                        system.debug('display name is  : '+stripeAPIResponse.Settings.dashboard.display_name);
             }
            }
            // Handle the case where the authentication with Stripe resulted in an error
            else if(stripeAPIResponse.error.message != null   )
            {
                
                String errorMessage = stripeAPIResponse.error.message;
                system.debug('error message  : '+errorMessage);
            }
            system.debug('final response that is retuned  : '+stripeAPIResponse);
            //string s=stripeAPIResponse.tostring();
            return stripeAPIResponse;

    }

    public static void updateStripeCustomsetting(String stripeMerchantName, String stripeSecretApiKey, String stripePublishableApiKey){
    logicpayment__Stripe_CustomSetting__c stripeCustomSetting = logicpayment__stripe_CustomSetting__c.getOrgDefaults();

    // Update the Custom Setting fields with the provided strip information
    stripeCustomSetting.logicpayment__Merchant_Name__c = stripeMerchantName;
    stripeCustomSetting.logicpayment__API_Secret_Key__c = stripeSecretApiKey;
    stripeCustomSetting.logicpayment__API_Publishable_Key__c = stripePublishableApiKey;
    system.debug('this is the updated setting '+stripeCustomSetting);
    upsert stripeCustomSetting;

}
public static void updateauthNetCustomsetting(String authorizeNetMerchantName, String authorizeNetApiLoginId, String authorizeNetTransactionKey){
    logicpayment__AuthorizeNet_CustomSettings__c authNetCustomSetting = logicpayment__AuthorizeNet_CustomSettings__c.getOrgDefaults();

                // Update the Custom Setting fields with the provided Authorize.Net information
                authNetCustomSetting.logicpayment__Merchant_Name__c = authorizeNetMerchantName;
                authNetCustomSetting.logicpayment__API_Login_Key__c = authorizeNetApiLoginId;
                authNetCustomSetting.logicpayment__Transaction_Key__c = authorizeNetTransactionKey;
                upsert authNetCustomSetting;

}

public static void updateglobalPaymentCustomsetting(String globalPaymentMerchantName, String globalPaymentAppId, String globalPaymentAppKey){
    logicpayment__GlobalPayment_CustomSetting__c	 globalPaymentCustomSetting = logicpayment__GlobalPayment_CustomSetting__c.getOrgDefaults();

            // Update the Custom Setting fields with the provided Global Payment information
            globalPaymentCustomSetting.logicpayment__Merchant_Name__c = globalPaymentMerchantName;
            globalPaymentCustomSetting.logicpayment__App_Id__c = globalPaymentAppId;
            globalPaymentCustomSetting.logicpayment__App_Key__c = globalPaymentAppKey;
            upsert globalPaymentCustomSetting;

}

@AuraEnabled
public static String authNetPrevMerchantName() {
    // Perform some logic and return data
    String authNetMerchantName;
    logicpayment__AuthorizeNet_CustomSettings__c authNetCustomSetting = logicpayment__AuthorizeNet_CustomSettings__c.getInstance();
        
        authNetMerchantName = authNetCustomSetting.logicpayment__Merchant_Name__c;
        system.debug('this is the returned response : '+authNetMerchantName);
    return authNetMerchantName;
}
@AuraEnabled
public static String stripePrevMerchantName() {
    // Perform some logic and return data
    String stripeMerchantName;
    logicpayment__stripe_CustomSetting__c stripeCustomSetting = logicpayment__stripe_CustomSetting__c.getInstance();
        
    stripeMerchantName = stripeCustomSetting.logicpayment__Merchant_Name__c;
        system.debug('this is the returned response : '+stripeMerchantName);
    return stripeMerchantName;
}
@AuraEnabled
public static String globalPaymentPrevMerchantName() {
    // Perform some logic and return data
    String globalPaymentMerchantName;
    logicpayment__GlobalPayment_CustomSetting__c globalPaymentCustomSetting = logicpayment__GlobalPayment_CustomSetting__c.getInstance();
        
    globalPaymentMerchantName = globalPaymentCustomSetting.logicpayment__Merchant_Name__c;
        system.debug('this is the returned response : '+globalPaymentMerchantName);
    return globalPaymentMerchantName;
}

}