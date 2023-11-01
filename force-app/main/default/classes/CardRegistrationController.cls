public with sharing class CardRegistrationController {

    //Method to authenticate Authorize.net Card Details
    @AuraEnabled
    public static AuthNetCustomerIDToCardInforWrapper authorizeNetCardAuthentication(String cardNumber, String cardExpirationDate, String cardCVV , Id accountId, String type )
    {
        
        try 
        {
            System.debug('In system debug Ok');
            // Create an instance of AuthNetGetCustomerIDToCardInfo
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateAuthNetCustomerId is due to its private variables
            AuthNetGetCustomerIDToCardInfo authNetInstance = new AuthNetGetCustomerIDToCardInfo();

            // Call the generateAuthNetCustomerId method on the instance
            AuthNetCustomerIDToCardInforWrapper authNetAPIResponse = authNetInstance.generateAuthNetCustomerId(cardNumber, cardExpirationDate, cardCVV, accountId, type);
            
            if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'ok')
            {
                System.debug('New Customer Profile Id::'+authNetAPIResponse.customerProfileId);
                System.debug('cardNumber::'+cardNumber);
                System.debug('cardExpirationDate::'+cardExpirationDate);
                System.debug('cardCVV::'+cardCVV);
            }
            // Handle the case where the authentication with Authorize.Net resulted in an error
            else if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'error')
            {
                System.debug('Error::'+authNetAPIResponse.Messages.message[0].text);
            }
            return authNetAPIResponse;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
        
    }




    //Method to authenticate Global Payment Card Details
    @AuraEnabled
    public static GlobalPayGetPaymentIDToCardInfoWrapper globalPaymentCardAuthentication(String cardNumber, String cardExpirationDate, String cardCVV, Id accountId, String type )
    {
        try 
        {
            system.debug('cardNumber'+cardNumber);
            system.debug('cardExpirationDate'+cardExpirationDate);
            system.debug('cardCVV'+cardCVV);
             // Create an instance of GlobalPayGetPaymentIDToCardInfo
             // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateGlobalPayGetPaymentID is due to its private variables
            GlobalPayGetPaymentIDToCardInfo globalPayInstance = new GlobalPayGetPaymentIDToCardInfo();
            // Call the generateGlobalPayGetPaymentID method on the instance
            GlobalPayGetPaymentIDToCardInfoWrapper globalPayAPIResponse = globalPayInstance.generateGlobalPayGetPaymentID(cardNumber, cardExpirationDate, cardCVV, accountId, type);
            if (globalPayAPIResponse.error_code == null) 
                {
                    System.debug('Response::'+globalPayAPIResponse);
                    System.debug('Payment Id : '+globalPayAPIResponse.id);
                } 
                else 
                {
                    // Handle HTTP errors here
                    System.debug('Error : '+globalPayAPIResponse.error_code);
                    System.debug('Error Description : '+globalPayAPIResponse.detailed_error_description);
                    
                }
            System.debug('globalPayAPIResponse::'+globalPayAPIResponse);
            return globalPayAPIResponse;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Method to authenticate Stripe Card Details
    @AuraEnabled
    public static void stripeCardAuthentication(String cardNumber, Integer expMonth, Integer expYear, String cvc)
    {
        try 
        {
            // Create an instance of AuthNetGetCustomerIDToCardInfo
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateAuthNetCustomerId is due to its private variables
            StripeGetTokenID stripeInstance = new StripeGetTokenID();

            // Call the generateAuthNetCustomerId method on the instance
            StripeGetCustomerIDWrapper stripeResponse = stripeInstance.createStripeToken(cardNumber, expMonth, expYear, cvc);
            if(stripeResponse.error == null)
            {
                System.debug('New Customer Profile Id::'+stripeResponse.id);
               
            }
            // Handle the case where the authentication with Authorize.Net resulted in an error
            else if(stripeResponse.error != null)
                {
                    System.debug('Error::'+stripeResponse.error.message);
                }
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
}