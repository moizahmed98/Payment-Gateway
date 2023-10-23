public with sharing class StripeRefundWrapper {
    public String id;
    public String objectType;
    public Decimal amount;
    public String balance_transaction;
    public String charge;
    public Long created;
    public String currencyType;
    public Map<String, Object> metadata;
    public String payment_intent;
    public String reason;
    public String receipt_number;
    public String source_transfer_reversal;
    public String status;
    public String transfer_reversal;
    public ErrorDetails error { get;  set; }

    public class ErrorDetails {
        public String code { get;  set; }
        public String doc_url { get;  set; }
        public String message { get;  set; }
        public String param { get;  set; }
        public String request_log_url { get;  set; }
        public String type { get;  set; }
    }
}