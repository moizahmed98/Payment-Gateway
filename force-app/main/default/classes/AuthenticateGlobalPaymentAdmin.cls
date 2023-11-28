public with sharing class AuthenticateGlobalPaymentAdmin {

    public static String tempURL;
    public static String tempRequestBody;
    public static String tempResponseBody;
    public static String tempStatus;
    //public static APILogsManager tempLogs;

    public static GlobalPayAdminWrapper authenticateGlobalPaymentAdminAPIForAdmin(String globalPaymentMerchantName, String globalPaymentAppId, String globalPaymentAppKey) {
        
        GlobalPayAdminWrapper tempWrapper = authenticateGlobalPaymentAdminAPI(globalPaymentMerchantName,globalPaymentAppId,globalPaymentAppKey);
        // Global Payments - Authenticate Admin
        APILogsManager.fillAPILogsData('Global Payments', 'Authenticate Admin', tempURL, tempRequestBody, tempResponseBody, tempStatus);
        return tempWrapper;
    }

    // Method to authenticate Global Payment Admin using API
    public static GlobalPayAdminWrapper authenticateGlobalPaymentAdminAPI(String globalPaymentMerchantName, String globalPaymentAppId, String globalPaymentAppKey) {
        // Generate a random nonce
        String nonce = generateRandomNonce();

        // Create a SHA-512 hash of nonce + app key to generate the secret
        String secret = generateSHA512Hash(nonce, globalPaymentAppKey);

        // Debugging nonce and secret values
        System.debug('Nonce :: ' + nonce);
        System.debug('Secret :: ' + secret);

        // API endpoint for access token
        String endPoint = 'https://apis.sandbox.globalpay.com/ucp/accesstoken';
        
        // Create an HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('X-GP-Version', '2021-03-22');
        
        // Create the request body with authentication details
        String requestBody = '{"app_id":"' + globalPaymentAppId + '","nonce":"' + nonce + '","secret":"' + secret + '","grant_type":"client_credentials" }';
        req.setBody(requestBody);

        // Send the HTTP request
        Http http = new Http();
        HttpResponse res = http.send(req);
        
         tempURL = endPoint;
         tempRequestBody = requestBody;
         tempResponseBody = String.valueOf(res.getBody());
         tempStatus = String.valueOf(res.getStatusCode());
        // Check the HTTP response status code
        if (res.getStatusCode() == 200) { 
            // Process the JSON response and store it in the GlobalPayAdminWrapper object
            GlobalPayAdminWrapper response = (GlobalPayAdminWrapper) JSON.deserialize(res.getBody(), GlobalPayAdminWrapper.class);
            System.debug('response::' + response);

            return response;
        } else {
            // Handle HTTP errors here
            GlobalPayAdminWrapper response = (GlobalPayAdminWrapper) JSON.deserialize(res.getBody(), GlobalPayAdminWrapper.class);
            System.debug('response::' + response);
            return response;
        }
    }

    // Method to generate a random nonce
    private static String generateRandomNonce() {
        String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        Integer length = 50;
        String nonce = '';
        for (Integer i = 0; i < length; i++) {
            Integer randomIndex = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            nonce += chars.substring(randomIndex, randomIndex + 1);
        }
        return nonce;
    }

    // Method to generate SHA-512 hash of a string
    private static String generateSHA512Hash(String input, String key) {
        Blob inputBlob = Blob.valueOf(input + key);
        Blob sha512Hash = Crypto.generateDigest('SHA-512', inputBlob);
        return EncodingUtil.convertToHex(sha512Hash);
    }
}