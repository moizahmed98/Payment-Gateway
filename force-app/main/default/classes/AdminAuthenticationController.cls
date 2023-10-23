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
}