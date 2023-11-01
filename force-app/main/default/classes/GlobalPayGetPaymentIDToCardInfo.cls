public with sharing class GlobalPayGetPaymentIDToCardInfo {
        private String globalPaymentMerchantName;
        private String globalPaymentAppId;
        private String globalPaymentAppKey;
        private String customerReference;

        // Constructor to initialize Api Login key, Transaction Key and GUID
        public GlobalPayGetPaymentIDToCardInfo() 
        {
            // Initialize custom settings
            logicpayment__GlobalPayment_CustomSetting__c globalPaymentCustomSetting = logicpayment__GlobalPayment_CustomSetting__c.getInstance();
            globalPaymentMerchantName = globalPaymentCustomSetting.logicpayment__Merchant_Name__c;
            globalPaymentAppId = globalPaymentCustomSetting.logicpayment__App_Id__c;
            globalPaymentAppKey = globalPaymentCustomSetting.logicpayment__App_Key__c;
            // Generate customerReference
            customerReference = generateCustomerReference();
        }
    
        // Method to generate customerReference
        private String generateCustomerReference() 
        {
            Blob guidBlob = Crypto.generateDigest('SHA-256', Blob.valueOf(String.valueOf(System.now().getTime())));
            String guidHex = EncodingUtil.convertToHex(guidBlob);
            //merchantCustomerId Accepts only 20 characters
            String guid = guidHex.substring(0, 20);
            return guid;
        }
    
        //HTTP Request to generate Payment Id
        public GlobalPayGetPaymentIDToCardInfoWrapper generateGlobalPayGetPaymentID(String cardNumber, String cardExpirationDate, String cardCVV, Id accountId, String Type) 
        {
            GlobalPayGetPaymentIDToCardInfoWrapper response = new GlobalPayGetPaymentIDToCardInfoWrapper();


            //Get Token
            GlobalPayAdminWrapper globalPaymentAPIResponse= AuthenticateGlobalPaymentAdmin.authenticateGlobalPaymentAdminAPI(globalPaymentMerchantName, globalPaymentAppId, globalPaymentAppKey);
            if(globalPaymentAPIResponse.error_code== null)
            {
                List<String> dateParts = cardExpirationDate.split('/');
    
                String endpointUrl = 'https://apis.sandbox.globalpay.com/ucp/payment-methods'; 
        
                // Construct the request body as a string
                String requestBody = '{' +
                                        '"reference": "' + customerReference + '",' +
                                        '"usage_mode": "MULTIPLE"' +',' +
                                        '"card": {' +
                                        '"number": "' + cardNumber + '",' +
                                        '"expiry_month": "' + dateParts[0] + '",' +
                                        '"expiry_year": "' + dateParts[1] + '",' +
                                        '"cvv": "' + cardCVV + '"' +
                                        '}' +
                                        '}';
    
                                      
                // Make the HTTP request
                HttpRequest request = new HttpRequest();
                request.setEndpoint(endpointUrl);
                request.setMethod('POST');
                request.setHeader('Content-Type', 'application/json');
                request.setHeader('X-GP-Version', '2021-03-22');
                request.setHeader('Authorization', 'Bearer '+globalPaymentAPIResponse.token);
                request.setBody(requestBody);
                System.debug('requestBody::'+requestBody);
                Http http = new Http();
                HttpResponse res = http.send(request);
    
                // Process the JSON response and store it in the GlobalPayGetPaymentIDToCardInfoWrapper object
                response = (GlobalPayGetPaymentIDToCardInfoWrapper)JSON.deserialize(res.getBody(), GlobalPayGetPaymentIDToCardInfoWrapper.class);
                if (res.getStatusCode() == 200) 
                {
                    System.debug('GlobalPayGetPaymentIDToCardInfo response::'+response);
                    System.debug('Payment Id : '+response.id);
                    // Get the last 4 digits of the card number
                    String lastFourDigits = cardNumber.substring(cardNumber.length() - 4);
        
                    // Create a masked card number with 'x' characters
                    String maskedCardNumber = 'xxxxxxxxxxxx' + lastFourDigits;
                    logicpayment__Payment__c newPaymentMethod = new logicpayment__Payment__c(logicpayment__Payment_Id__c=response.id,logicpayment__Reference__c=response.reference,logicpayment__Account__c=accountId,logicpayment__Card__c=maskedCardNumber,logicpayment__Type__c=Type);
                    insert newPaymentMethod;
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
            
            system.debug('Response:' + response);
           
            return response;
        }
    
}