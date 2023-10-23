public  class CardRegistrationController {
    //Method to authenticate Authorize.net Card Details
    @AuraEnabled
    public static AuthNetCustomerIDToCardInforWrapper authorizeNetCardAuthentication(String cardNumber, String cardExpirationDate, String cardCVV )
    {
        try 
        {
            //Transform date into required input format
            Integer currentYearFirstTwoDigits = Date.today().year() / 100;
            String transformedDate = currentYearFirstTwoDigits + cardExpirationDate.substring(3, 5) + '-' + cardExpirationDate.substring(0, 2);
            // Create an instance of AuthNetGetCustomerIDToCardInfo
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateAuthNetCustomerId is due to its private variables
            AuthNetGetCustomerIDToCardInfo authNetInstance = new AuthNetGetCustomerIDToCardInfo();

            // Call the generateAuthNetCustomerId method on the instance
            AuthNetCustomerIDToCardInforWrapper authNetAPIResponse = authNetInstance.generateAuthNetCustomerId(cardNumber, cardExpirationDate, cardCVV);
            /*if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'ok')
            {
                System.debug('New Customer Profile Id::'+authNetAPIResponse.customerProfileId);
                System.debug('cardNumber::'+cardNumber);
                System.debug('cardExpirationDate::'+cardExpirationDate);
                System.debug('cardCVV::'+cardCVV);
                return authNetAPIResponse;
            }
            // Handle the case where the authentication with Authorize.Net resulted in an error
            else if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'error')
            {
                return authNetAPIResponse;
            }*/
            System.debug('authNetAPIResponse::'+authNetAPIResponse);
            return authNetAPIResponse;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Method to authenticate Global Payment Card Details
    @AuraEnabled
    public static void globalPaymentCardAuthentication(String cardNumber, String cardExpirationDate, String cardCVV )
    {
        try 
        {
            
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
}