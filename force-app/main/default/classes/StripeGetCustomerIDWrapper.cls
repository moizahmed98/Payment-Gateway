public with sharing class StripeGetCustomerIDWrapper {
    public String id { get; set; }
    public String objectType { get; set; }
    public String address { get; set; }
    public Decimal balance { get; set; }
    public Long created { get; set; }
    public String currencyType { get; set; }
    public String default_source { get; set; }
    public Boolean delinquent { get; set; }
    public String description { get; set; }
    public String discount { get; set; }
    public String email { get; set; }
    public String invoice_prefix { get; set; }
    public InvoiceSettings invoice_settings { get; set; }
    public Boolean livemode { get; set; }
    public Map<String, Object> metadata { get; set; }
    public String name { get; set; }
    public Integer next_invoice_sequence { get; set; }
    public String phone { get; set; }
    public List<String> preferred_locales { get; set; }
    public String shipping { get; set; }
    public String tax_exempt { get; set; }
    public String test_clock { get; set; }
    public ErrorDetails error { get;  set; }

    public class InvoiceSettings {
        public String custom_fields { get; set; }
        public String default_payment_method { get; set; }
        public String footer { get; set; }
        public String rendering_options { get; set; }
    }
    
    
        public class ErrorDetails {
            public String code { get;  set; }
            public String doc_url { get;  set; }
            public String message { get;  set; }
            public String param { get;  set; }
            public String request_log_url { get;  set; }
            public String type { get;  set; }
        }
       

    
      
    }
    