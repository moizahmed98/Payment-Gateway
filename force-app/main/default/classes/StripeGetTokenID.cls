public with sharing class StripeGetTokenID {
    private String stripeApiPublishableKey;
    public StripeGetTokenID() 
    {
        // Initialize custom settings
        logicpayment__Stripe_CustomSetting__c stripeCustomSetting = logicpayment__Stripe_CustomSetting__c.getInstance();
        
        stripeApiPublishableKey = stripeCustomSetting.logicpayment__API_Publishable_Key__c;
       
    }
    
        public StripeGetCustomerIDWrapper createStripeToken(String cardNumber, String cardExpirationDate, String cardCVV, Id accountId, String type) {
           // String apiKey = 'pk_test_51NncOzKg6zD1tMM3mVHeFKB0mqgnBVWxTVyfanxA4w1T4AyPFij7RxtyoTFHlvU0w4qsVc9Q1eNHyBpZdkdKipYO00yH6etIj6'; // Replace with your Stripe secret key
           List<String> dateParts = cardExpirationDate.split('/');
            String tokenEndpoint = 'https://api.stripe.com/v1/tokens';
    
            HttpRequest req = new HttpRequest();
            req.setEndpoint(tokenEndpoint);
            req.setMethod('POST');
            req.setHeader('Authorization', 'Bearer ' + stripeApiPublishableKey);
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
    
            // Construct the request body
            String requestBody = 'card[number]=' + EncodingUtil.urlEncode(cardNumber, 'UTF-8') + '&'
                              + 'card[exp_month]=' + EncodingUtil.urlEncode(dateParts[0], 'UTF-8') + '&'
                              + 'card[exp_year]=' + EncodingUtil.urlEncode(dateParts[1], 'UTF-8') + '&'
                              + 'card[cvc]=' + EncodingUtil.urlEncode(cardCVV, 'UTF-8');
    
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
            // Stripe - Token Generation
            APILogsManager.fillAPILogsData('Stripe', 'Token Generation', tokenEndpoint, requestBody, String.valueOf(res.getBody()), String.valueOf(res.getStatusCode()));
            // Stripe - Add Card
            APILogsManager.fillAPILogsData('Stripe', 'Add Card', StripeGetCustomerID.tempURL, StripeGetCustomerID.tempRequestBody, StripeGetCustomerID.tempResponseBody, StripeGetCustomerID.tempStatus);

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