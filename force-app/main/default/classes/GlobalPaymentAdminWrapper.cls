public with sharing class GlobalPaymentAdminWrapper {

    @AuraEnabled
    public String token { get; set; }
    
    @AuraEnabled
    public String type { get; set; }
    
    @AuraEnabled
    public String error_code { get; set; }
    
    @AuraEnabled
    public String detailed_error_code { get; set; }
    
    @AuraEnabled
    public String detailed_error_description { get; set; }

    @AuraEnabled
    public scope scope { get; set; }

    public class scope 
    {
        @AuraEnabled
        public String merchant_id { get; set; }
        
        @AuraEnabled
        public String merchant_name { get; set; }
    }
}