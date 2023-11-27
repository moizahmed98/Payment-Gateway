public class AuthNetTransactionProcessing {
    private String authNetApiLoginKey;
    private String authNetTransactionKey;

    // Constructor to initialize Api Login key and Transaction Key
    public AuthNetTransactionProcessing() 
    {
        // Initialize custom settings
        logicpayment__AuthorizeNet_CustomSettings__c authNetCustomSetting = logicpayment__AuthorizeNet_CustomSettings__c.getInstance();
        authNetApiLoginKey = authNetCustomSetting.logicpayment__API_Login_Key__c;
        authNetTransactionKey = authNetCustomSetting.logicpayment__Transaction_Key__c;
        
    }

    //HTTP Request to perform transaction
    public AuthNetTransactionProcessingWrapper generateAuthNetTransaction(String transactionAction, String transactionAmount, String customerProfileId, String paymentProfileId ) 
    {
        String endpointUrl = 'https://apitest.authorize.net/xml/v1/request.api'; 

        //Check if the transaction is to be Credited or Debited
        if(transactionAction == 'Pay'){
            transactionAction = 'authCaptureTransaction';
        }
        else {
            transactionAction = 'refundTransaction';
        }

        // Construct the request body as a string
        String requestBody = '{'+
                                '"createTransactionRequest": {' +
                                '"merchantAuthentication": {' +
                                '"name": "' + authNetApiLoginKey + '",' +
                                '"transactionKey": "' + authNetTransactionKey + '"' +
                                '},' +
                                '"transactionRequest": {' +
                                '"transactionType": "' + transactionAction + '",' +
                                '"amount": "' + transactionAmount + '",' +
                                '"profile": {' +
                                '"customerProfileId": "' + customerProfileId + '",' +
                                '"paymentProfile": {' +
                                '"paymentProfileId": "' + paymentProfileId + '"' +
                                '}' +
                                '}' +
                                '}' +
                                '}}';

        // Make the HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpointUrl);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(requestBody);
        System.debug('AuthNetTransactionProcessing requestBody::'+requestBody);
        Http http = new Http();
        HttpResponse res = http.send(request);
        // Authorize.Net - Transaction Processing
        APILogsManager.fillAPILogsData('Authorize.Net', 'Transaction Processing', endpointUrl, requestBody, String.valueOf(res.getBody()), String.valueOf(res.getStatusCode()));

        if (res.getStatusCode() == 200) 
        {
            // Process the JSON response and store it in the AuthNetTransactionProcessingWrapper object
            String responseBody = res.getBody();
            // Trim any leading BOM  (Byte Order Mark) character (0xfeff) if present
            if (responseBody.startsWithIgnoreCase('\uFEFF')) 
            {
                responseBody = responseBody.substring(1);
            }
            AuthNetTransactionProcessingWrapper response = (AuthNetTransactionProcessingWrapper)JSON.deserialize(responseBody, AuthNetTransactionProcessingWrapper.class);
            System.debug('AuthNetTransactionProcessing response::'+response);
            return response;
        } 
        else 
        {
            // Handle HTTP errors here
            AuthNetTransactionProcessingWrapper errorResponse = new AuthNetTransactionProcessingWrapper();
            errorResponse.Messages.resultCode = 'Error';
            errorResponse.Messages.message[0].code = 'HTTP_ERROR';
            errorResponse.Messages.message[0].text = 'HTTP Request Failed';
            return errorResponse;
        }
    }
}