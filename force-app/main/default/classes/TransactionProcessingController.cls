public class TransactionProcessingController {
    //Method to pay or refund Stripe transaction
    @AuraEnabled
    public static void authorizeNetTransaction(String transactionAction, Decimal transactionAmount, String recordId )
    {
        try 
        {
            //Fetch CustomerProfileId & PaymentProfileId related to that Account
            //Account transactionAccount = [Select id, name, paymentProfileId, customerProfileId From Account Where id =: recordId];

            // Create an instance of AuthNetTransactionProcessing
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateAuthNetTransaction is due to its private variables
          

            // Call the generateAuthNetTransaction method on the instance
           
            if(transactionAction == 'pay')
            {
                StripeCreateCharge charge = new StripeCreateCharge(); // Create an instance of StripeCreateCharge
                String customerId = 'cus_OpSU0sBgsP5alF';
                Decimal amount = transactionAmount; // Replace with the actual amount
                String currencyusd = 'USD'; // Replace with the actual currency

                    charge.chargeCustomer(customerId, amount, currencyusd);

                System.debug('apyment::');
            }
            // Handle the case where the authentication with Stripe resulted in an error
            else if(transactionAction == 'refund')
            {
                
                StripeRefund refund = new StripeRefund(); // Create an instance of StripeRrefund
                String chargeId = 'ch_3O2BmsKg6zD1tMM30WVS9z9j';
                Decimal amount = transactionAmount; // Replace with the actual amount
                

                refund.refundCharge(chargeId, amount);

                System.debug('refund::');
                
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
            
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
}