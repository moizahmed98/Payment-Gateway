public with sharing class GlobalPayTransactionProcessingWrapper 
{
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public DateTime time_created { get; set; }
    @AuraEnabled
    public String type { get; set; }
    @AuraEnabled
    public String status { get; set; }
    @AuraEnabled
    public String channel { get; set; }
    @AuraEnabled
    public String capture_mode { get; set; }
    @AuraEnabled
    public String amount { get; set; }
    @AuraEnabled
    public String country { get; set; }
    @AuraEnabled
    public String merchant_id { get; set; }
    @AuraEnabled
    public String merchant_name { get; set; }
    @AuraEnabled
    public String account_id { get; set; }
    @AuraEnabled
    public String reference { get; set; }
    @AuraEnabled
    public String error_code { get; set; }
    @AuraEnabled
    public String detailed_error_code { get; set; }
    @AuraEnabled
    public String detailed_error_description { get; set; }

    @AuraEnabled
    public PaymentMethod payment_method { get; set; }
    @AuraEnabled
    public List<RiskAssessment> risk_assessment { get; set; }
    @AuraEnabled
    public String batch_id { get; set; }
    @AuraEnabled
    public ActionData action { get; set; }
    
    public class PaymentMethod {
        @AuraEnabled
        public String result { get; set; }
        @AuraEnabled
        public String message { get; set; }
        @AuraEnabled
        public String entry_mode { get; set; }
        @AuraEnabled
        public CardDetails card { get; set; }
    }
    
    public class CardDetails {
        @AuraEnabled
        public String funding { get; set; }
        @AuraEnabled
        public String brand { get; set; }
        @AuraEnabled
        public String masked_number_last4 { get; set; }
        @AuraEnabled
        public String authcode { get; set; }
        @AuraEnabled
        public String brand_reference { get; set; }
        @AuraEnabled
        public String cvv_result { get; set; }
        @AuraEnabled
        public String avs_address_result { get; set; }
        @AuraEnabled
        public String avs_postal_code_result { get; set; }
        @AuraEnabled
        public Provider provider { get; set; }
    }
    
    public class Provider {
        @AuraEnabled
        public String result { get; set; }
        @AuraEnabled
        public String cvv_result { get; set; }
        @AuraEnabled
        public String avs_address_result { get; set; }
        @AuraEnabled
        public String avs_postal_code_result { get; set; }
    }
    
    public class RiskAssessment {
        @AuraEnabled
        public String mode { get; set; }
        @AuraEnabled
        public String result { get; set; }
        @AuraEnabled
        public List<Rule> rules { get; set; }
    }
    
    public class Rule {
        @AuraEnabled
        public String reference { get; set; }
        @AuraEnabled
        public String description { get; set; }
        @AuraEnabled
        public String mode { get; set; }
        @AuraEnabled
        public String result { get; set; }
    }
    
    public class ActionData {
        @AuraEnabled
        public String id { get; set; }
        @AuraEnabled
        public String type { get; set; }
        @AuraEnabled
        public DateTime time_created { get; set; }
        @AuraEnabled
        public String result_code { get; set; }
        @AuraEnabled
        public String app_id { get; set; }
        @AuraEnabled
        public String app_name { get; set; }
    }
}