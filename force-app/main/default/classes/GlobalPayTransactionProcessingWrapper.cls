public with sharing class GlobalPayTransactionProcessingWrapper 
{
        public String id { get; set; }
        public DateTime time_created { get; set; }
        public String type { get; set; }
        public String status { get; set; }
        public String channel { get; set; }
        public String capture_mode { get; set; }
        public String amount { get; set; }
        public String country { get; set; }
        public String merchant_id { get; set; }
        public String merchant_name { get; set; }
        public String account_id { get; set; }
        public String reference { get; set; }
        public String error_code { get; set; }
        public String detailed_error_code { get; set; }
        public String detailed_error_description { get; set; }
        
        public PaymentMethod payment_method { get; set; }
        public List<RiskAssessment> risk_assessment { get; set; }
        public String batch_id { get; set; }
        public ActionData action { get; set; }
        
        public class PaymentMethod {
            public String result { get; set; }
            public String message { get; set; }
            public String entry_mode { get; set; }
            public CardDetails card { get; set; }
        }
        
        public class CardDetails {
            public String funding { get; set; }
            public String brand { get; set; }
            public String masked_number_last4 { get; set; }
            public String authcode { get; set; }
            public String brand_reference { get; set; }
            public String cvv_result { get; set; }
            public String avs_address_result { get; set; }
            public String avs_postal_code_result { get; set; }
            public Provider provider { get; set; }
        }
        
        public class Provider {
            public String result { get; set; }
            public String cvv_result { get; set; }
            public String avs_address_result { get; set; }
            public String avs_postal_code_result { get; set; }
        }
        
        public class RiskAssessment {
            public String mode { get; set; }
            public String result { get; set; }
            public List<Rule> rules { get; set; }
        }
        
        public class Rule {
            public String reference { get; set; }
            public String description { get; set; }
            public String mode { get; set; }
            public String result { get; set; }
        }
        
        public class ActionData {
            public String id { get; set; }
            public String type { get; set; }
            public DateTime time_created { get; set; }
            public String result_code { get; set; }
            public String app_id { get; set; }
            public String app_name { get; set; }
        }
}