public with sharing class AdminAuthenticationController 
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
                logicpayment__AuthorizeNet_CustomSettings__c authNetCustomSetting = logicpayment__AuthorizeNet_CustomSettings__c.getOrgDefaults();

                // Update the Custom Setting fields with the provided Authorize.Net information
                authNetCustomSetting.logicpayment__Merchant_Name__c = authorizeNetMerchantName;
                authNetCustomSetting.logicpayment__API_Login_Key__c = authorizeNetApiLoginId;
                authNetCustomSetting.logicpayment__Transaction_Key__c = authorizeNetTransactionKey;
                upsert authNetCustomSetting;
            }
            // Handle the case where the authentication with Authorize.Net resulted in an error
            else if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'error')
            {

            }
            return authNetAPIResponse;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Method to authenticate Global Payment Merchant account
    @AuraEnabled
    public static string globalPaymentAdminAuth(String globalPaymentMerchantName, String globalPaymentAppId, String globalPaymentAppKey )
    {
        try 
        {
            return null;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Method to authenticate Stripe Merchant account
    @AuraEnabled
    public static StripeAdminWrapper StripeAdminAuth(String stripeMerchantName, String stripeSecretApiKey, String stripePublishableApiKey )
    {
       
            StripeAdminWrapper stripeAPIResponse= AuthenticateStripeAdmin.authenticateStripeAdminAPI(stripeMerchantName, stripeSecretApiKey);
            System.debug('stripeAPIResponse::      '+stripeAPIResponse);
            System.debug('stripeAPIResponse Error::      '+stripeAPIResponse);
           
            // Check if the authentication with Stripe was successful (result code is 'Ok')
            


            if(stripeAPIResponse.error == null  )
            {
                system.debug('in first if ');
                if(stripeAPIResponse.Settings.dashboard.display_name == stripeMerchantName)
                {
                    system.debug('the  display name is correct and the merchant is authenticated');
                    // Retrieve the org-level default Custom Setting record for Stripe
                    logicpayment__Stripe_CustomSetting__c stripeCustomSetting = logicpayment__Stripe_CustomSetting__c.getOrgDefaults();

                    // Update the Custom Setting fields with the provided strip information
                    stripeCustomSetting.logicpayment__Merchant_Name__c = stripeMerchantName;
                    stripeCustomSetting.logicpayment__API_Secret_Key__c = stripeSecretApiKey;
                    stripeCustomSetting.logicpayment__API_Publishable_Key__c = stripePublishableApiKey;
                    system.debug(stripeCustomSetting);
                    upsert stripeCustomSetting;
                }
                else if(stripeAPIResponse.Settings.dashboard.display_name != stripeMerchantName)
                {
                    system.debug('display name is not correct');
                }
                
            }
            // Handle the case where the authentication with Stripe resulted in an error
            else if(stripeAPIResponse.error.message != null   )
            {
                
                String errorMessage = stripeAPIResponse.error.message;
                system.debug('api key is not correct : '+errorMessage);
                

            }
            return stripeAPIResponse;

    }
}