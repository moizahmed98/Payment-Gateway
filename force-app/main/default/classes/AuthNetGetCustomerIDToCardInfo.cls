public class AuthNetGetCustomerIDToCardInfo 
{
    private String merchantCustomerId;
    private String authNetApiLoginKey;
    private String authNetTransactionKey;

    // Constructor to initialize Api Login key, Transaction Key and GUID
    public AuthNetGetCustomerIDToCardInfo() 
    {
        // Initialize custom settings
        logicpayment__AuthorizeNet_CustomSettings__c authNetCustomSetting = logicpayment__AuthorizeNet_CustomSettings__c.getInstance();
        authNetApiLoginKey = authNetCustomSetting.logicpayment__API_Login_Key__c;
        authNetTransactionKey = authNetCustomSetting.logicpayment__Transaction_Key__c;

        // Generate merchantCustomerId
        merchantCustomerId = generateMerchantCustomerId();
    }

    // Method to generate merchantCustomerId
    private String generateMerchantCustomerId() 
    {
        Blob guidBlob = Crypto.generateDigest('SHA-256', Blob.valueOf(String.valueOf(System.now().getTime())));
        String guidHex = EncodingUtil.convertToHex(guidBlob);
        //merchantCustomerId Accepts only 20 characters
        String guid = guidHex.substring(0, 20);
        return guid;
    }

    //HTTP Request to generate Customer Id
    public AuthNetCustomerIDToCardInforWrapper generateAuthNetCustomerId(String cardNumber, String cardExpirationDate, String cardCVV,Id accountId, String type) 
    {
        system.debug('In Main Ok');
        String endpointUrl = 'https://apitest.authorize.net/xml/v1/request.api'; 

        // Construct the request body as a string
        String requestBody = '{' +
                                '"createCustomerProfileRequest": {' +
                                '"merchantAuthentication": {' +
                                '"name": "' + authNetApiLoginKey + '",' +
                                '"transactionKey": "' + authNetTransactionKey + '"' +
                                '},' +
                                '"profile": {' +
                                '"merchantCustomerId": "' + merchantCustomerId + '",' +
                                '"paymentProfiles": {' +
                                '"customerType": "individual",' +
                                '"payment": {' +
                                '"creditCard": {' +
                                '"cardNumber": "' + cardNumber + '",' +
                                '"expirationDate": "' + cardExpirationDate + '",' +
                                '"cardCode": "' + cardCVV + '",' +
                                '}' +
                                '}' +
                                '}' +
                                '},' +
                                '"validationMode": "testMode"' +
                                '}' +
                                '}';

        // Make the HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(requestBody);
        System.debug('requestBody::'+requestBody);
        Http http = new Http();
        HttpResponse res = http.send(request);
        // Authorize.Net - Add Card
        APILogsManager.fillAPILogsData('Authorize.Net', 'Add Card', endpointUrl, requestBody, String.valueOf(res.getBody()), String.valueOf(res.getStatusCode()));

        if (res.getStatusCode() == 200) 
        {
            // Process the JSON response and store it in the AuthNetCustomerIDToCardInforWrapper object
            String responseBody = res.getBody();
            // Trim any leading BOM  (Byte Order Mark) character (0xfeff) if present
            if (responseBody.startsWithIgnoreCase('\uFEFF')) 
            {
                responseBody = responseBody.substring(1);
            }
            AuthNetCustomerIDToCardInforWrapper response = (AuthNetCustomerIDToCardInforWrapper)JSON.deserialize(responseBody, AuthNetCustomerIDToCardInforWrapper.class);
            System.debug('AuthNetGetCustomerIDToCardInfo response::'+response);
            if(response.Messages.resultCode != null && response.Messages.resultCode.toLowerCase() == 'ok')
            {
                // Get the last 4 digits of the card number
            String lastFourDigits = cardNumber.substring(cardNumber.length() - 4);
            system.debug(response);
            // Create a masked card number with 'x' characters
            String maskedCardNumber = 'xxxxxxxxxxxx' + lastFourDigits;
            logicpayment__Payment__c newPaymentMethod = new logicpayment__Payment__c(logicpayment__Customer_Payment_Id__c=response.customerProfileId,logicpayment__Payment_Id__c=response.customerPaymentProfileIdList[0],logicpayment__Account__c=accountId,logicpayment__Card__c=maskedCardNumber,logicpayment__Type__c=Type);
            system.debug(newPaymentMethod);
            insert newPaymentMethod;
            }
            // Handle the case where the authentication with Authorize.Net resulted in an error
            else if(response.Messages.resultCode != null && response.Messages.resultCode.toLowerCase() == 'error')
            {
                System.debug('Error::'+response.Messages.message[0].text);
            }



            
            return response;
        } 
        else 
        {
            // Handle HTTP errors here
            AuthNetCustomerIDToCardInforWrapper errorResponse = new AuthNetCustomerIDToCardInforWrapper();
            errorResponse.Messages.resultCode = 'Error';
            errorResponse.Messages.message[0].code = 'HTTP_ERROR';
            errorResponse.Messages.message[0].text = 'HTTP Request Failed';
            return errorResponse;
        }
    }
}