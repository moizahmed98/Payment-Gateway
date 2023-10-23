public with sharing class StripeGetTokenID {
    private String stripeApiPublishableKey;

    //Constructor to intialize secret key 
    public StripeGetTokenID() 
    {
        // Initialize custom settings
        logicpayment__Stripe_CustomSetting__c stripeCustomSetting = logicpayment__Stripe_CustomSetting__c.getInstance();
        
        stripeApiPublishableKey = stripeCustomSetting.logicpayment__API_Publishable_Key__c;
       
    }
    
        public StripeGetCustomerIDWrapper createStripeToken(String cardNumber, Integer expMonth, Integer expYear, String cvc) {
           // String apiKey = 'pk_test_51NncOzKg6zD1tMM3mVHeFKB0mqgnBVWxTVyfanxA4w1T4AyPFij7RxtyoTFHlvU0w4qsVc9Q1eNHyBpZdkdKipYO00yH6etIj6'; // Replace with your Stripe secret key
    
            String tokenEndpoint = 'https://api.stripe.com/v1/tokens';
    
            HttpRequest req = new HttpRequest();
            req.setEndpoint(tokenEndpoint);
            req.setMethod('POST');
            req.setHeader('Authorization', 'Bearer ' + stripeApiPublishableKey);
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
    
            // Construct the request body
            String requestBody = 'card[number]=' + EncodingUtil.urlEncode(cardNumber, 'UTF-8') + '&'
                              + 'card[exp_month]=' + EncodingUtil.urlEncode(String.valueOf(expMonth), 'UTF-8') + '&'
                              + 'card[exp_year]=' + EncodingUtil.urlEncode(String.valueOf(expYear), 'UTF-8') + '&'
                              + 'card[cvc]=' + EncodingUtil.urlEncode(cvc, 'UTF-8');
    
            req.setBody(requestBody);
    
            Http http = new Http();
            HttpResponse res = http.send(req);
        system.debug('this is the response code  :'+res.getStatusCode());
        if (res.getStatusCode() == 200) {
            String responseBody = res.getBody();
            StripeGetTokenIDWrapper response = (StripeGetTokenIDWrapper)JSON.deserialize(responseBody, StripeGetTokenIDWrapper.class);
            system.debug('this is the id from wrapper : '+response.id);
            // Create an instance of StripeGetCustomerID
            StripeGetCustomerID customerIDInstance = new StripeGetCustomerID();

            StripeGetCustomerIDWrapper responseCustomerId = customerIDInstance.createStripeCustomer(response.id);
            
            system.debug('this is the customer id funtion called from token class : '+response.id);
            return responseCustomerId;
            } 
            else {

                String responseBody = res.getBody();
                StripeGetCustomerIDWrapper response = (StripeGetCustomerIDWrapper)JSON.deserialize(responseBody, StripeGetCustomerIDWrapper.class);
                system.debug('this is the error from wrapper : '+response.error.message);
                return response;// Error handling
            }


    }
}