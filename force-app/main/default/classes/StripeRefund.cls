public class StripeRefund {
    
    private static final String STRIPE_API_BASE_URL = 'https://api.stripe.com/v1';

    private String stripeApiSecretKey;

    //Constructor to intialize secret key 
    public StripeRefund() 
    {
        // Initialize custom settings
        logicpayment__Stripe_CustomSetting__c stripeCustomSetting = logicpayment__Stripe_CustomSetting__c.getInstance();
        
        stripeApiSecretKey = stripeCustomSetting.logicpayment__API_Secret_Key__c;
       
    }

    // Method to refund a specific charge
    public StripeRefundWrapper refundCharge(String chargeId, Decimal amount) {
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        
        // Construct the API request
        request.setEndpoint(STRIPE_API_BASE_URL + '/refunds');
        request.setMethod('POST');
        request.setHeader('Authorization', 'Bearer ' + stripeApiSecretKey);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody('charge=' + chargeId + '&amount=' + amount);

        
            Http http = new Http();
            response = http.send(request);

            if (response.getStatusCode() == 200) {
                // Refund successful
                String responseBody = response.getBody();
                StripeRefundWrapper responseInWrapper = (StripeRefundWrapper)JSON.deserialize(responseBody, StripeRefundWrapper.class);
                 system.debug('this is the id from wrapper : '+responseInWrapper.id);
               
                System.debug('Refund successful: ' + response.getBody());
                return responseInWrapper;
            } else {
                // Refund failed
                String responseBody = response.getBody();
                StripeRefundWrapper responseInWrapper = (StripeRefundWrapper)JSON.deserialize(responseBody, StripeRefundWrapper.class);
                 system.debug('this is the error from wrapper : '+responseInWrapper.error.code);
                
                System.debug('Refund failed: ' + response.getBody());
                return responseInWrapper;
            }
        
    }
}
