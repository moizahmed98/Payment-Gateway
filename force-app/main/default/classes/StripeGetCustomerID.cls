public class StripeGetCustomerID {
    private String stripeApiSecretKey;
    public final String STRIPE_API_URL = 'https://api.stripe.com/v1/customers';

    //Constructor to intialize secret key 
    public StripeGetCustomerID() 
    {
        // Initialize custom settings
        logicpayment__Stripe_CustomSetting__c stripeCustomSetting = logicpayment__Stripe_CustomSetting__c.getInstance();
        
        stripeApiSecretKey = stripeCustomSetting.logicpayment__API_Secret_Key__c;
       
    }

    // Define your Stripe API credentials
    //public static final String STRIPE_API_KEY = 'sk_test_51NncOzKg6zD1tMM3dMvwIYEPhBR0M0jL6kMUivJoJpzmjjvmByEMDBKRM04eNp8AfG9gtHuwNA270gSRz6zy4uBL00poJjgukC';

    // Stripe API URL for creating customers
   

    // Method to create a customer in Stripe with a card token as the source
    public StripeGetCustomerIDWrapper createStripeCustomer(String cardToken) {
        String customerData = 'description=New Customer&source=' + cardToken; // Include the card token as the source parameter.

        HttpRequest request = new HttpRequest();
        request.setEndpoint(STRIPE_API_URL);
        request.setMethod('POST');
        request.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(stripeApiSecretKey + ':')));
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody(customerData);

        Http http = new Http();
        HttpResponse response = http.send(request);

        // Check if the HTTP request was successful
        if (response.getStatusCode() == 200) {
            // Parse the response to get the customer ID
            String responseBody = response.getBody();
            
            StripeGetCustomerIDWrapper responseInWrapper = (StripeGetCustomerIDWrapper)JSON.deserialize(responseBody, StripeGetCustomerIDWrapper.class);
            
            
            system.debug('this is the id from wrapper : '+responseInWrapper.id);
           
            return responseInWrapper;
        } else {
            // Handle the error (you might want to log it or throw an exception)

            String responseBody = response.getBody();
            
            StripeGetCustomerIDWrapper responseInWrapper = (StripeGetCustomerIDWrapper)JSON.deserialize(responseBody, StripeGetCustomerIDWrapper.class);
            
            
            system.debug('this is the error from wrapper : '+responseInWrapper.error.code);
           
            return responseInWrapper;
            
        }
    }
}
