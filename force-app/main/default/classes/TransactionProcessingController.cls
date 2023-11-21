public class TransactionProcessingController {
    //Method to pay or refund Authorize.net transaction
    @AuraEnabled
    public static AuthNetTransactionProcessingWrapper authorizeNetTransaction(String transactionAction, String transactionAmount, String recordId )
    {
        System.debug('authNetaction::'+transactionAction);
        System.debug('authNetamount::'+transactionAmount);
        System.debug('authNetrecordid::'+recordId);
        try 
        {
            //Fetch CustomerProfileId & PaymentProfileId related to that Account
            //Account transactionAccount = [Select id, name, paymentProfileId, customerProfileId From Account Where id =: recordId];

            // Create an instance of AuthNetTransactionProcessing
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateAuthNetTransaction is due to its private variables
            logicpayment__Payment__c transactionlist = [Select id,logicpayment__Payment_Id__c, logicpayment__Customer_Payment_Id__c From logicpayment__Payment__c Where id =: recordId];
            System.debug('transaction list ::'+transactionlist);
            System.debug('transaction list payment id ::'+transactionlist.logicpayment__Payment_Id__c);
            AuthNetTransactionProcessing authNetInstance = new AuthNetTransactionProcessing();

            // Call the generateAuthNetTransaction method on the instance
            AuthNetTransactionProcessingWrapper authNetAPIResponse = authNetInstance.generateAuthNetTransaction(transactionAction, transactionAmount , transactionlist.logicpayment__Customer_Payment_Id__c , transactionlist.logicpayment__Payment_Id__c );
            if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'ok')
            {
                System.debug('Succesfull::'+authNetAPIResponse.TransactionResponse.messages[0].description);
                logicpayment__Transaction__c Transactions = new logicpayment__Transaction__c();
                //Transactions.logicpayment__ChargeId__c = globalPayAPIResponse.id; // Set the charge id  field value
                Transactions.logicpayment__TransactionId__c = authNetAPIResponse.transactionResponse.transId;
                Transactions.logicpayment__Payment__c = recordId;
                Transactions.logicpayment__Transaction_Amount__c = Decimal.valueOf(transactionAmount) ;
                if(transactionAction == 'Pay')
                Transactions.logicpayment__Transaction_Type__c = 'Payment';
                else if (transactionAction == 'refund')
                Transactions.logicpayment__Transaction_Type__c = 'Refund';
                   // Insert the record into the database
                   try {
                       insert Transactions;
                       System.debug('Record inserted successfully.');
                   } catch (DmlException e) {
                       System.debug('Error inserting record: ' + e.getMessage());
                   }
            }
            // Handle the case where the authentication with Authorize.Net resulted in an error
            else if(authNetAPIResponse.Messages.resultCode != null && authNetAPIResponse.Messages.resultCode.toLowerCase() == 'error')
            {
                System.debug('Error::'+authNetAPIResponse.Messages.message[0].text);
                if(authNetAPIResponse.Messages.message[0].text.toLowerCase() == 'the transaction was unsuccessful.')
                {
                    system.debug('populating custom error ');
                    // Throw Error: A duplicate transaction has been submitted. Wait 2 minutes for to perform same transaction.
                    AuthNetTransactionProcessingWrapper errorResponse = new AuthNetTransactionProcessingWrapper();

                    // Make sure Messages and message list are initialized before accessing their properties
                    errorResponse.Messages = new AuthNetTransactionProcessingWrapper.Messages();
                    errorResponse.Messages.resultCode = 'Error';

                    // Initialize the message list
                    errorResponse.Messages.message = new List<AuthNetTransactionProcessingWrapper.Message>();

                    // Add a new Message to the list
                    AuthNetTransactionProcessingWrapper.Message errorMessage = new AuthNetTransactionProcessingWrapper.Message();
                    errorMessage.code = 'Duplicate Transaction';
                    errorMessage.text = 'A duplicate transaction has been submitted. Wait 2 minutes to perform the same transaction.';
                    errorResponse.Messages.message.add(errorMessage);

                    return errorResponse;
                }
            }

            return authNetAPIResponse;
        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Method to pay or refund Stripe transaction

     @AuraEnabled
    public static StripeCreateChargeWrapper stripeTransaction(String transactionAction, Decimal transactionAmount, String recordId )
    {
        System.debug('STRIPEaction::'+transactionAction);
        System.debug('STRIPEamount::'+transactionAmount);
        System.debug('STRIPErecordid::'+recordId);
         // Convert cents to dollars
         Integer transactionAmountInCents = (Integer)(transactionAmount * 100);

         // Display the result
         System.debug('Transaction Amount in Cents: ' + transactionAmountInCents);
         
         // Now, transactionAmount holds the value in dollars
         System.debug('Amount in cents: ' + transactionAmountInCents);
        try 
        {
            //Fetch CustomerProfileId & PaymentProfileId related to that Account
            //Account transactionAccount = [Select id, name, paymentProfileId, customerProfileId From Account Where id =: recordId];

            // Create an instance of AuthNetTransactionProcessing
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateAuthNetTransaction is due to its private variables
            logicpayment__Payment__c paymentlist = [Select id,logicpayment__Payment_Id__c, logicpayment__Customer_Payment_Id__c From logicpayment__Payment__c Where id =: recordId];
            System.debug('transaction list ::'+paymentlist);
           // System.debug('transaction list payment id ::'+transactionlist.logicpayment__Payment_Id__c);

            // Call the generateAuthNetTransaction method on the instance
           
            
                StripeCreateCharge charge = new StripeCreateCharge(); // Create an instance of StripeCreateCharge
                String customerId = paymentlist.logicpayment__Customer_Payment_Id__c;
                Decimal amount = transactionAmountInCents; // Replace with the actual amount
                String currencyusd = 'USD'; // Replace with the actual currency

                StripeCreateChargeWrapper StripeCreateChargeAPIResponse = charge.chargeCustomer(customerId, amount, currencyusd);



                if(StripeCreateChargeAPIResponse.error == null  )
                {
                    System.debug('Payment sucessfull and the follwinfg response is returned  ::'+StripeCreateChargeAPIResponse.id);

                    // Create a new Custom_Object__Transaction record
                    logicpayment__Transaction__c Transactions = new logicpayment__Transaction__c();
                    Transactions.logicpayment__ChargeId__c = StripeCreateChargeAPIResponse.id; // Set the charge id  field value
                    Transactions.logicpayment__TransactionId__c = StripeCreateChargeAPIResponse.balance_transaction;
                    Transactions.logicpayment__Payment__c = recordId;
                    Transactions.logicpayment__Transaction_Amount__c = transactionAmount;
                    Transactions.logicpayment__Transaction_Type__c = 'Payment';
                       // Insert the record into the database
                       try {
                           insert Transactions;
                           System.debug('Record inserted successfully.');
                       } catch (DmlException e) {
                           System.debug('Error inserting record: ' + e.getMessage());
                       }
   
                   System.debug('payment succesfull');
                 }
                
                // Handle the case where the authentication with Stripe resulted in an error
                else if(StripeCreateChargeAPIResponse.error.message != null   )
                {
                    
                    String errorMessage = StripeCreateChargeAPIResponse.error.message;
                    system.debug('error message  : '+errorMessage);
                }
                system.debug('final response that is retuned  : '+StripeCreateChargeAPIResponse);
                //string s=stripeAPIResponse.tostring();
                
    
            
            return StripeCreateChargeAPIResponse;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
               
            
            // Handle the case where the authentication with Stripe resulted in an error
         
            
            
        }
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    //Method to pay or refund Global Payment transaction
    @AuraEnabled
    public static GlobalPayTransactionProcessingWrapper globalPaymentTransaction(String transactionAction, String transactionAmount, String recordId  )
    {
        System.debug('GPaction::'+transactionAction);
        System.debug('GPamount::'+transactionAmount);
        System.debug('GPrecordid::'+recordId);
        try 
        {
            // Create an instance of AuthNetTransactionProcessing
            // We are doing this because Non static method cannot be referenced from a static context
            // Non Static context for generateGlobalPayTransaction is due to its private variables

            logicpayment__Payment__c transactionlist = [Select id,logicpayment__Payment_Id__c, logicpayment__Customer_Payment_Id__c,logicpayment__Reference__c From logicpayment__Payment__c Where id =: recordId];
            System.debug('transaction list ::'+transactionlist);
            System.debug('transaction list payment id ::'+transactionlist.logicpayment__Payment_Id__c);
            GlobalPayTransactionProcessing globalPayInstance = new GlobalPayTransactionProcessing();
            // Call the generateGlobalPayTransaction method on the instance
            GlobalPayTransactionProcessingWrapper globalPayAPIResponse = globalPayInstance.generateGlobalPayTransaction(transactionAction, transactionAmount , transactionlist.logicpayment__Reference__c , transactionlist.logicpayment__Payment_Id__c );
            if (globalPayAPIResponse.error_code == null) 
            {
                System.debug('Succesfull::'+globalPayAPIResponse);
                System.debug('Transaction Id : '+globalPayAPIResponse.id);
                logicpayment__Transaction__c Transactions = new logicpayment__Transaction__c();
                    //Transactions.logicpayment__ChargeId__c = globalPayAPIResponse.id; // Set the charge id  field value
                    Transactions.logicpayment__TransactionId__c = globalPayAPIResponse.id;
                    Transactions.logicpayment__Payment__c = recordId;
                    Transactions.logicpayment__Transaction_Amount__c = Decimal.valueOf(transactionAmount) ;
                    if(transactionAction == 'Pay')
                    Transactions.logicpayment__Transaction_Type__c = 'Payment';
                    else if (transactionAction == 'refund')
                    Transactions.logicpayment__Transaction_Type__c = 'Refund';
                       // Insert the record into the database
                       try {
                           insert Transactions;
                           System.debug('Record inserted successfully.');
                       } catch (DmlException e) {
                           System.debug('Error inserting record: ' + e.getMessage());
                       }
            } 
            else 
            {
                // Handle HTTP errors here
                System.debug('Error : '+globalPayAPIResponse.error_code);
                System.debug('Error Description : '+globalPayAPIResponse.detailed_error_description);
                
            }
            return globalPayAPIResponse;

        } 
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

//////////////////////////////////////////////////////////////////***************method to refund stripe ***************************\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
  
@AuraEnabled
public static StripeRefundWrapper stripeTransactionRefund(String transactionAction, Decimal transactionAmount, String recordId )
{
    System.debug('STRIPEaction::'+transactionAction);
    System.debug('STRIPEamount::'+transactionAmount);
    System.debug('STRIPErecordid::'+recordId);
    // Convert cents to dollars
    Integer transactionAmountInCents = (Integer)(transactionAmount * 100);

// Display the result
System.debug('Transaction Amount in Cents: ' + transactionAmountInCents);

// Now, transactionAmount holds the value in dollars
System.debug('Amount in cents: ' + transactionAmountInCents);
    try 
    {
        //Fetch CustomerProfileId & PaymentProfileId related to that Account
        //Account transactionAccount = [Select id, name, paymentProfileId, customerProfileId From Account Where id =: recordId];


             list<logicpayment__Transaction__c>  transactionlist = [Select id,logicpayment__ChargeId__c From logicpayment__Transaction__c Where logicpayment__Payment__c =: recordId order by logicpayment__Transaction_Amount__c desc];
                System.debug('transaction list ::'+transactionlist);
                
                if (transactionlist.size() > 0)
                {   System.debug('in loop');
                    StripeRefund refund = new StripeRefund(); // Create an instance of StripeRrefund
                String chargeId = transactionlist[0].logicpayment__ChargeId__c;
                Decimal amount = transactionAmountInCents; // Replace with the actual amount
                
                StripeRefundWrapper StripeRefundAPIResponse = refund.refundCharge(chargeId, amount);

                if(StripeRefundAPIResponse.error == null  )
                {
                    System.debug('Payment sucessfull and the follwinfg response is returned  ::'+StripeRefundAPIResponse.id);

                    // Create a new Custom_Object__Transaction record
                    logicpayment__Transaction__c Transactions = new logicpayment__Transaction__c();
                    Transactions.logicpayment__ChargeId__c = chargeId; // Set the charge id  field value
                    Transactions.logicpayment__TransactionId__c = StripeRefundAPIResponse.balance_transaction;
                    Transactions.logicpayment__Payment__c = recordId;
                    Transactions.logicpayment__Transaction_Type__c = 'Refund';
                    Transactions.logicpayment__Transaction_Amount__c = transactionAmount;

                       // Insert the record into the database
                       try {
                           insert Transactions;
                           System.debug('Record inserted successfully.');
                       } catch (DmlException e) {
                           System.debug('Error inserting record: ' + e.getMessage());
                       }
   
                   System.debug('payment succesfull');
                 }
                
                // Handle the case where the authentication with Stripe resulted in an error
                else if(StripeRefundAPIResponse.error.message != null   )
                {
                    
                    String errorMessage = StripeRefundAPIResponse.error.message;
                    system.debug('error message  : '+errorMessage);
                }
                system.debug('final response that is retuned  : '+StripeRefundAPIResponse);
                //string s=stripeAPIResponse.tostring();
                
                System.debug('refund::'+StripeRefundAPIResponse);
                return StripeRefundAPIResponse;

                }
                else{

                    StripeRefundWrapper errorResponse = new StripeRefundWrapper();
                    errorResponse.error.code = 'No SEND transacction found!';
                    errorResponse.error.message = 'To process the refund, please initiate one or more send transactions. Thank you!.';
            
            return errorResponse;
                }

                

              

                
                
            }

        // Create an instance of AuthNetTransactionProcessing
        // We are doing this because Non static method cannot be referenced from a static context
        // Non Static context for generateAuthNetTransaction is due to its private variables
      
     
        
        
    
                catch (Exception e) 
                {
                    throw new AuraHandledException(e.getMessage());
                }
            }
}