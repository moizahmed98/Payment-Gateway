public with sharing class AuthenticateGlobalPaymentAdmin {


public static GlobalPaymentAdminWrapper AuthenticateGlobalPaymentAdminAPI(String globalPaymentMerchantName, String globalPaymentAppId, String globalPaymentAppKey) {
    String nonce = '';
    String secret = '';
    String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Integer Length = 50;
    for (Integer i = 0; i < length; i++)
    {
    Integer randomIndex = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
    nonce += chars.substring(randomIndex, randomIndex + 1);
    }
        Blob inputBlob = Blob.valueOf(nonce+globalPaymentAppKey);
        Blob sha512Hash = Crypto.generateDigest('SHA-512', inputBlob);
        secret= EncodingUtil.convertToHex(sha512Hash);

    
String endPoint = 'https://apis.sandbox.globalpay.com/ucp/accesstoken';
HttpRequest req = new HttpRequest();
req.setEndpoint(endPoint);
req.setMethod('POST');
req.setHeader('Content-Type', 'application/json');
req.setHeader('X-GP-Version', '2021-03-22');
String requestBody = '{"app_id":"' + globalPaymentAppId + '","nonce":"' + nonce + '","secret":"' + secret + '","grant_type":"client_credentials" }';
req.setBody(requestBody);

Http http = new Http();
HttpResponse res = http.send(req);

if (res.getStatusCode() == 200) { 
    // Process the JSON response and store it in the GlobalPaymentAdminWrapper object
    GlobalPaymentAdminWrapper response = (GlobalPaymentAdminWrapper) JSON.deserialize(res.getBody(), GlobalPaymentAdminWrapper.class);
    System.debug('response::' + response);
    return response;
} else {
    // Handle HTTP errors here
    // Handle HTTP errors here
    GlobalPaymentAdminWrapper response = (GlobalPaymentAdminWrapper) JSON.deserialize(res.getBody(), GlobalPaymentAdminWrapper.class);
    System.debug('response::' + response);
    return response;
}

}
}