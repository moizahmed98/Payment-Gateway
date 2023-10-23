public with sharing  class StripeCreateCharge {
    private static final String STRIPE_API_BASE_URL = 'https://api.stripe.com/v1';

    private String stripeApiSecretKey;

    //Constructor to intialize secret key 
    public StripeCreateCharge() 
    {
        // Initialize custom settings
        logicpayment__Stripe_CustomSetting__c stripeCustomSetting = logicpayment__Stripe_CustomSetting__c.getInstance();
        
        stripeApiSecretKey = stripeCustomSetting.logicpayment__API_Secret_Key__c;
       
    }

    // Method to charge a customer using their customer ID
    public StripeCreateChargeWrapper chargeCustomer(String customerId, Decimal amount, String currencyusd) {
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        
        // Construct the API request
        request.setEndpoint(STRIPE_API_BASE_URL + '/charges');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + stripeApiSecretKey);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody('amount=' + amount + '&currency=' + currencyusd + '&customer=' + customerId);

        
            Http http = new Http();
            response = http.send(request);

            if (response.getStatusCode() == 200) {
                // Payment successful
                String responseBody = response.getBody();
            
                StripeCreateChargeWrapper responseInWrapper = (StripeCreateChargeWrapper)JSON.deserialize(responseBody, StripeCreateChargeWrapper.class);
                
                
                system.debug('this is the id from wrapper : '+responseInWrapper.id);
                System.debug('Payment successful: ' + response.getBody());
                return responseInWrapper;
            } else {
                // Payment failed
                String responseBody = response.getBody();
            
                StripeCreateChargeWrapper responseInWrapper = (StripeCreateChargeWrapper)JSON.deserialize(responseBody, StripeCreateChargeWrapper.class);
                
                
                system.debug('this is the error from wrapper : '+responseInWrapper.error.code);
               
               
                
                System.debug('Payment failed: ' + response.getBody());
                return responseInWrapper;
            }
         
    }
}
