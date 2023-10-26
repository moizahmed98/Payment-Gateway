public with sharing class AuthenticateSquareAdmin {
    
    // Method to authenticate Square Admin using API
    public static SquareAdminWrapper authenticateSquareAdminAPI(String squareMerchantName, String squareApplicationId, String squareAccessToken) {
     

        // API endpoint for access token
        String endPoint = 'https://connect.squareupsandbox.com/v2/merchants/';
        
        // Create an HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Square-Version', '2023-10-18');
        req.setHeader('Authorization', 'Bearer '+squareAccessToken);  

        // Send the HTTP request
        Http http = new Http();
        HttpResponse res = http.send(req);


        // Process the JSON response and store it in the SquareAdminWrapper object
        SquareAdminWrapper response = (SquareAdminWrapper) JSON.deserialize(res.getBody(), SquareAdminWrapper.class);
        System.debug('response::' + response);


        // Check the HTTP response status code
        if (res.getStatusCode() == 200) { 
            return response;
        } else {
            // Handle HTTP errors here
            return response;
        }
    }

}