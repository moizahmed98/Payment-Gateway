public class TransactionProcessingController {
    //Method to pay or refund Authorize.net transaction
    @AuraEnabled
    public static void authorizeNetTransaction(String transactionAction, String transactionAmount, String recordId )
    {
        try 
        {
            //Fetch CustomerProfileId & PaymentProfileId related to that Account
            //Account transactionAccount = [Select id, name, paymentProfileId, customerProfileId From Account Where id =: recordId];

            // Create an instance of AuthNetTransactionProcessing
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateAuthNetTransaction is due to its private variables
            AuthNetTransactionProcessing authNetInstance = new AuthNetTransactionProcessing();

            // Call the generateAuthNetTransaction method on the instance
            AuthNetTransactionProcessingWrapper authNetAPIResponse = authNetInstance.generateAuthNetTransaction('Pay', '20.00' , '915218121' , '914588810' );
            if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'ok')
            {
                System.debug('Succesfull::'+authNetAPIResponse.TransactionResponse.messages[0].description);
            }
            // Handle the case where the authentication with Authorize.Net resulted in an error
            else if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'error')
            {
                System.debug('Error::'+authNetAPIResponse.Messages.message[0].text);
                if(authNetAPIResponse.Messages.message[0].text.toLowerCase() == 'the transaction was unsuccessful.')
                {
                    // Throw Error: A duplicate transaction has been submitted. Wait 2 minutes for to perform same transaction.
                }
            }

            
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Method to pay or refund Global Payment transaction
    @AuraEnabled
    public static void globalPaymentTransaction(String transactionAction, String transactionAmount, String recordId  )
    {
        try 
        {
            // Create an instance of AuthNetTransactionProcessing
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateGlobalPayTransaction is due to its private variables
            GlobalPayTransactionProcessing globalPayInstance = new GlobalPayTransactionProcessing();
            // Call the generateGlobalPayTransaction method on the instance
            GlobalPayTransactionProcessingWrapper globalPayAPIResponse = globalPayInstance.generateGlobalPayTransaction('Pay', '20.00' , '915218121' , '914588810' );
            if (globalPayAPIResponse.error_code == null) 
            {
                System.debug('Succesfull::'+globalPayAPIResponse);
                System.debug('Transaction Id : '+globalPayAPIResponse.id);
            } 
            else 
            {
                // Handle HTTP errors here
                System.debug('Error : '+globalPayAPIResponse.error_code);
                System.debug('Error Description : '+globalPayAPIResponse.detailed_error_description);
                
            }

        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
}