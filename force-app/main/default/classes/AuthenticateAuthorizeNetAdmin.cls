public with sharing class AuthenticateAuthorizeNetAdmin 
{
    public static AuthNetAdminWrapper authenticateAuthorizeNetAdminAPI(String authorizeNetMrchantName, String authorizeNetApiLoginId, String authorizeNetTransactionKey) 
    {
        String endPoint = 'https://apitest.authorize.net/xml/v1/request.api';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        String requestBody = '{"authenticateTestRequest":{"merchantAuthentication":{"name":"' + authorizeNetApiLoginId + '","transactionKey":"' + authorizeNetTransactionKey + '"}}}';
        req.setBody(requestBody);

        Http http = new Http();
        HttpResponse res = http.send(req);
        // Authorize.Net - Add Card
        APILogsManager.fillAPILogsData('Authorize.Net', 'Authenticate Token Keys', endPoint, requestBody, String.valueOf(res.getBody()), String.valueOf(res.getStatusCode()));


        if (res.getStatusCode() == 200) 
        {
            // Process the JSON response and store it in the AuthNetAdminWrapper object
            String responseBody = res.getBody();
            // Trim any leading BOM  (Byte Order Mark) character (0xfeff) if present
            if (responseBody.startsWithIgnoreCase('\uFEFF')) 
            {
                responseBody = responseBody.substring(1);
            }
            AuthNetAdminWrapper response = (AuthNetAdminWrapper)JSON.deserialize(responseBody, AuthNetAdminWrapper.class);
            return response;
        } 
        else 
        {
            // Handle HTTP errors here
            AuthNetAdminWrapper errorResponse = new AuthNetAdminWrapper();
            errorResponse.Messages.resultCode = 'Error';
            errorResponse.Messages.message[0].code = 'HTTP_ERROR';
            errorResponse.Messages.message[0].text = 'HTTP Request Failed';
            return errorResponse;
        }
    }
}