public with sharing class AuthenticateStripeAdmin 
{
    public static StripeAdminWrapper authenticateStripeAdminAPI(String stripeMerchantName, String stripeSecretApiKey) 
    {
        String endPoint = 'https://api.stripe.com/v1/account';
        String password = '';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Blob headerValue = Blob.valueOf(stripeSecretApiKey + ':' + password);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) 
        {
            // Process the JSON response and store it in the AuthNetAdminWrapper object
            String responseBody = res.getBody();
            system.debug('this is the response'+responseBody);
            // Trim any leading BOM  (Byte Order Mark) character (0xfeff) if present
            /*if (responseBody.startsWithIgnoreCase('\uFEFF')) 
            {
                responseBody = responseBody.substring(1);
            }*/
            StripeAdminWrapper response = (StripeAdminWrapper)JSON.deserialize(responseBody, StripeAdminWrapper.class);
            
            return response;
        } 
        else 
        {
            // Handle HTTP errors here
            system.debug('in else');
            String responseBody = res.getBody();
            system.debug('this is the response'+responseBody);
            StripeAdminWrapper response = (StripeAdminWrapper)JSON.deserialize(responseBody, StripeAdminWrapper.class);
            return response;
           /* StripeAdminWrapper errorResponse = new StripeAdminWrapper();
            errorResponse.Messages.resultCode = 'Error';
            errorResponse.Messages.message[0].code = 'HTTP_ERROR';
            errorResponse.Messages.message[0].text = 'HTTP Request Failed';*/
           
        }
       
    }
}