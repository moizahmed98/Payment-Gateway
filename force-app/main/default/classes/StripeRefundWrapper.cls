public with sharing class StripeRefundWrapper {
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String objectType;
    @AuraEnabled
    public Decimal amount;
    @AuraEnabled
    public String balance_transaction;
    @AuraEnabled
    public String charge;
    @AuraEnabled
    public Long created;
    @AuraEnabled
    public String currencyType;
    @AuraEnabled
    public Map<String, Object> metadata;
    @AuraEnabled
    public String payment_intent;
    @AuraEnabled
    public String reason;
    @AuraEnabled
    public String receipt_number;
    @AuraEnabled
    public String source_transfer_reversal;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public String transfer_reversal;
    @AuraEnabled
    public ErrorDetails error { get;  set; }

    public class ErrorDetails {
        @AuraEnabled
        public String code { get;  set; }
        @AuraEnabled
        public String doc_url { get;  set; }
        @AuraEnabled
        public String message { get;  set; }
        @AuraEnabled
        public String param { get;  set; }
        @AuraEnabled
        public String request_log_url { get;  set; }
        @AuraEnabled
        public String type { get;  set; }
    }
    public StripeRefundWrapper() {
        // Initialize the error object in the constructor
        this.error = new ErrorDetails();
    }
}