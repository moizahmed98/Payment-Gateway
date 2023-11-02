public with sharing class StripeGetCustomerIDWrapper {
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String objectType { get; set; }
    @AuraEnabled public String address { get; set; }
    @AuraEnabled public Decimal balance { get; set; }
    @AuraEnabled public Long created { get; set; }
    @AuraEnabled public String currencyType { get; set; }
    @AuraEnabled public String default_source { get; set; }
    @AuraEnabled public Boolean delinquent { get; set; }
    @AuraEnabled public String description { get; set; }
    @AuraEnabled public String discount { get; set; }
    @AuraEnabled public String email { get; set; }
    @AuraEnabled public String invoice_prefix { get; set; }
    @AuraEnabled public InvoiceSettings invoice_settings { get; set; }
    @AuraEnabled public Boolean livemode { get; set; }
    @AuraEnabled public Map<String, Object> metadata { get; set; }
    @AuraEnabled public String name { get; set; }
    @AuraEnabled public Integer next_invoice_sequence { get; set; }
    @AuraEnabled public String phone { get; set; }
    @AuraEnabled public List<String> preferred_locales { get; set; }
    @AuraEnabled public String shipping { get; set; }
    @AuraEnabled public String tax_exempt { get; set; }
    @AuraEnabled public String test_clock { get; set; }
    @AuraEnabled public ErrorDetails error { get;  set; }

    public class InvoiceSettings {
        @AuraEnabled public String custom_fields { get; set; }
        @AuraEnabled public String default_payment_method { get; set; }
        @AuraEnabled public String footer { get; set; }
        @AuraEnabled public String rendering_options { get; set; }
    }
    
    
        public class ErrorDetails {
            @AuraEnabled public String code { get;  set; }
            @AuraEnabled public String doc_url { get;  set; }
            @AuraEnabled public String message { get;  set; }
            @AuraEnabled public String param { get;  set; }
            @AuraEnabled public String request_log_url { get;  set; }
            @AuraEnabled public String type { get;  set; }
        }
       

    
      
    }