public with sharing class GlobalPayTransactionProcessing {
    private String globalPaymentMerchantName;
        private String globalPaymentAppId;
        private String globalPaymentAppKey;
        

    public GlobalPayTransactionProcessing() {
         // Initialize custom settings
         logicpayment__GlobalPayment_CustomSetting__c globalPaymentCustomSetting = logicpayment__GlobalPayment_CustomSetting__c.getInstance();
         globalPaymentMerchantName = globalPaymentCustomSetting.logicpayment__Merchant_Name__c;
         globalPaymentAppId = globalPaymentCustomSetting.logicpayment__App_Id__c;
         globalPaymentAppKey = globalPaymentCustomSetting.logicpayment__App_Key__c;
    }

    
     //HTTP Request to perform transaction
    public GlobalPayTransactionProcessingWrapper generateGlobalPayTransaction(String transactionAction, String transactionAmount, String customerReference, String PaymentId ) 
    {
        String endpointUrl = 'https://apis.sandbox.globalpay.com/ucp/transactions'; 

        //Check if the transaction is to be Credited or Debited
        if(transactionAction == 'Pay'){
            transactionAction = 'SALE';
        }
        else {
            transactionAction = 'REFUND';
        }

        // Construct the request body as a string
        String requestBody = '{'+
                                '"account_name": "transaction_processing",' +
                                '"channel": "CNP",' +
                                '"type": "' + transactionAction + '",' +
                                '"amount": "' + transactionAmount + '",' +
                                '"currency": "USD",' +
                                '"reference": "' + customerReference + '",' +
                                '"country": "US",' +
                                '"payment_method": {' +
                                '"id": "' + PaymentId + '",' +
                                '"entry_mode": "ECOM"' +
                                '}}';


        GlobalPayTransactionProcessingWrapper response = new   GlobalPayTransactionProcessingWrapper();                     
        //Get Token
        GlobalPayAdminWrapper globalPaymentAPIResponse= AuthenticateGlobalPaymentAdmin.authenticateGlobalPaymentAdminAPI(globalPaymentMerchantName, globalPaymentAppId, globalPaymentAppKey );                        
        if(globalPaymentAPIResponse.error_code== null)
        {
            // Make the HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('X-GP-Version', '2021-03-22');
        request.setHeader('Authorization', 'Bearer '+globalPaymentAPIResponse.token);
        request.setBody(requestBody);
        System.debug('GlobalPayTransactionProcessing requestBody::'+requestBody);
        Http http = new Http();
        HttpResponse res = http.send(request);
        // Global Payments - Transaction Processing
        APILogsManager.fillAPILogsData('Global Payments', 'Transaction Processing', endpointUrl, requestBody, String.valueOf(res.getBody()), String.valueOf(res.getStatusCode()));

        response = (GlobalPayTransactionProcessingWrapper)JSON.deserialize(res.getBody(), GlobalPayTransactionProcessingWrapper.class);
        if (res.getStatusCode() == 200) 
            {
                System.debug('Response::'+response);
                System.debug('Transaction Id : '+response.id);
            } 
            else 
            {
                // Handle HTTP errors here
                System.debug('Error : '+response.error_code);
                System.debug('Error Description : '+response.detailed_error_description);
                
            }
        }
        else
        {
            response.error_code=globalPaymentAPIResponse.error_code;
            response.detailed_error_description=globalPaymentAPIResponse.detailed_error_description;
            System.debug('Error : '+globalPaymentAPIResponse.error_code);
            System.debug('Error Description : '+globalPaymentAPIResponse.detailed_error_description);
        }

            return response;
    }
    


}