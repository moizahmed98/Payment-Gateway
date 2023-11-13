public class StripeCreateChargeWrapper {
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String objectType;
    @AuraEnabled
    public Decimal amount;
    @AuraEnabled
    public Decimal amount_captured;
    @AuraEnabled
    public Decimal amount_refunded;
    @AuraEnabled
    public String balance_transaction;
    @AuraEnabled
    public BillingDetails billing_details;
    @AuraEnabled
    public String calculated_statement_descriptor;
    @AuraEnabled
    public Boolean captured;
    @AuraEnabled
    public Long created;
    @AuraEnabled
    public String currencyusd;
    @AuraEnabled
    public String customer;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public String destination;
    @AuraEnabled
    public String dispute;
    @AuraEnabled
    public Boolean disputed;
    @AuraEnabled
    public String failure_balance_transaction;
    @AuraEnabled
    public String failure_code;
    @AuraEnabled
    public String failure_message;
    @AuraEnabled
    public Map<String, Object> fraud_details;
    @AuraEnabled
    public String invoice;
    @AuraEnabled
    public Boolean livemode;
    @AuraEnabled
    public Map<String, Object> metadata;
    @AuraEnabled
    public String on_behalf_of;
    @AuraEnabled
    public String order;
    @AuraEnabled
    public Outcome outcome;
    @AuraEnabled
    public Boolean paid;
    @AuraEnabled
    public String payment_intent;
    @AuraEnabled
    public String payment_method;
    @AuraEnabled
    public PaymentMethodDetails payment_method_details;
    @AuraEnabled
    public String receipt_email;
    @AuraEnabled
    public String receipt_number;
    @AuraEnabled
    public String receipt_url;
    @AuraEnabled
    public Boolean refunded;
    @AuraEnabled
    public String review;
    @AuraEnabled
    public Map<String, Object> shipping;
    @AuraEnabled
    public Source source;
    @AuraEnabled
    public String source_transfer;
    @AuraEnabled
    public String statement_descriptor;
    @AuraEnabled
    public String statement_descriptor_suffix;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public Map<String, Object> transfer_data;
    @AuraEnabled
    public String transfer_group;
    @AuraEnabled
    public ErrorDetails error { get;  set; }

    public class BillingDetails {
        @AuraEnabled
        public Address address;
        @AuraEnabled
        public String email;
        @AuraEnabled
        public String name;
        @AuraEnabled
        public String phone;
    }

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

    public class Address {
        @AuraEnabled
        public String city;
        @AuraEnabled
        public String country;
        @AuraEnabled
        public String line1;
        @AuraEnabled
        public String line2;
        @AuraEnabled
        public String postal_code;
        @AuraEnabled
        public String state;
    }

    public class Outcome {
        @AuraEnabled
        public String network_status;
        @AuraEnabled
        public String reason;
        @AuraEnabled
        public String risk_level;
        @AuraEnabled
        public Integer risk_score;
        @AuraEnabled
        public String seller_message;
        @AuraEnabled
        public String type;
    }

    public class PaymentMethodDetails {
        @AuraEnabled
        public Card card;
        @AuraEnabled
        public String type;
    }

    public class Card {
        @AuraEnabled
        public Decimal amount_authorized;
        @AuraEnabled
        public String brand;
        @AuraEnabled
        public Checks checks;
        @AuraEnabled
        public String country;
        @AuraEnabled
        public Integer exp_month;
        @AuraEnabled
        public Integer exp_year;
        @AuraEnabled
        public ExtendedAuthorization extended_authorization;
        @AuraEnabled
        public String fingerprint;
        @AuraEnabled
        public String funding;
        @AuraEnabled
        public IncrementalAuthorization incremental_authorization;
        @AuraEnabled
        public Integer installments;
        @AuraEnabled
        public String last4;
        @AuraEnabled
        public String mandate;
        @AuraEnabled
        public Multicapture multicapture;
        @AuraEnabled
        public String network;
        @AuraEnabled
        public NetworkToken network_token;
        @AuraEnabled
        public Overcapture overcapture;
        @AuraEnabled
        public String three_d_secure;
        @AuraEnabled
        public String wallet;
    }

    public class Checks {
        @AuraEnabled
        public String address_line1_check;
        @AuraEnabled
        public String address_postal_code_check;
        @AuraEnabled
        public String cvc_check;
    }

    public class ExtendedAuthorization {
        @AuraEnabled
        public String status;
    }

    public class IncrementalAuthorization {
        @AuraEnabled
        public String status;
    }

    public class Multicapture {
        @AuraEnabled
        public String status;
    }

    public class NetworkToken {
        @AuraEnabled
        public Boolean used;
    }

    public class Overcapture {
        @AuraEnabled
        public Decimal maximum_amount_capturable;
        @AuraEnabled
        public String status;
    }

    public class Source {
        @AuraEnabled
        public String id;
        @AuraEnabled
        public String objectType;
        @AuraEnabled
        public String address_city;
        @AuraEnabled
        public String address_country;
        @AuraEnabled
        public String address_line1;
        @AuraEnabled
        public String address_line1_check;
        @AuraEnabled
        public String address_line2;
        @AuraEnabled
        public String address_state;
        @AuraEnabled
        public String address_zip;
        @AuraEnabled
        public String address_zip_check;
        @AuraEnabled
        public String brand;
        @AuraEnabled
        public String country;
        @AuraEnabled
        public String customer;
        @AuraEnabled
        public String cvc_check;
        @AuraEnabled
        public String dynamic_last4;
        @AuraEnabled
        public Integer exp_month;
        @AuraEnabled
        public Integer exp_year;
        @AuraEnabled
        public String fingerprint;
        @AuraEnabled
        public String funding;
        @AuraEnabled
        public String last4;
        @AuraEnabled
        public Map<String, Object> metadata;
        @AuraEnabled
        public String name;
        @AuraEnabled
        public String tokenization_method;
        @AuraEnabled
        public String wallet;
    }
}