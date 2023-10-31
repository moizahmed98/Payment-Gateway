public with sharing class AdminAuthenticationController 
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
    public static GlobalPayAdminWrapper globalPaymentAdminAuth(String globalPaymentMerchantName, String globalPaymentAppId, String globalPaymentAppKey )
    {
        try 
        {
            GlobalPayAdminWrapper globalPaymentAPIResponse= AuthenticateGlobalPaymentAdmin.authenticateGlobalPaymentAdminAPI(globalPaymentMerchantName, globalPaymentAppId, globalPaymentAppKey );
            System.debug('globalPaymentAPIResponse::'+globalPaymentAPIResponse);
            // Check if the authentication with Global Payment was successful (result code is 'Ok')
            if(globalPaymentAPIResponse.error_code== null )
            {
                // Retrieve the org-level default Custom Setting record for Global Payment
                logicpayment__GlobalPayment_CustomSetting__c	 globalPaymentCustomSetting = logicpayment__GlobalPayment_CustomSetting__c.getOrgDefaults();

                // Update the Custom Setting fields with the provided Global Payment information
                globalPaymentCustomSetting.logicpayment__Merchant_Name__c = globalPaymentMerchantName;
                globalPaymentCustomSetting.logicpayment__App_Id__c = globalPaymentAppId;
                globalPaymentCustomSetting.logicpayment__App_Key__c = globalPaymentAppKey;
                upsert globalPaymentCustomSetting;
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

    //Method to authenticate Square Merchant account
    @AuraEnabled
    public static SquareAdminWrapper squareAdminAuth(String squareMerchantName, String squareApplicationId, String squareAccessToken)
    {
        try 
        {
            SquareAdminWrapper squareAPIResponse= AuthenticateSquareAdmin.authenticateSquareAdminAPI(squareMerchantName, squareApplicationId, squareAccessToken);
            System.debug('squareAPIResponse::'+squareAPIResponse);
            // Check if the authentication with Square was successful (result code is 'Ok')
            if(squareAPIResponse.errors== null )
            {
                // Retrieve the org-level default Custom Setting record for Square
                logicpayment__Square_CustomSettings__c	 squareCustomSetting = logicpayment__Square_CustomSettings__c.getOrgDefaults();

                // Update the Custom Setting fields with the provided Square information
                squareCustomSetting.logicpayment__Merchant_Name__c = squareMerchantName;
                squareCustomSetting.logicpayment__Application_Id__c = squareApplicationId;
                squareCustomSetting.logicpayment__Access_Token__c = squareAccessToken;
                upsert squareCustomSetting;
            }
            // Handle the case where the authentication with Square resulted in an error
            else
            {
                System.debug('Error : '+squareAPIResponse.errors[0].code);
                System.debug('Error Description : '+squareAPIResponse.errors[0].detail);
            }
            return squareAPIResponse;
            
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
}