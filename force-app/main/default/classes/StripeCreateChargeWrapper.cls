public class StripeCreateChargeWrapper {
    public String id;
    public String objectType;
    public Decimal amount;
    public Decimal amount_captured;
    public Decimal amount_refunded;
    public String balance_transaction;
    public BillingDetails billing_details;
    public String calculated_statement_descriptor;
    public Boolean captured;
    public Long created;
    public String currencyusd;
    public String customer;
    public String description;
    public String destination;
    public String dispute;
    public Boolean disputed;
    public String failure_balance_transaction;
    public String failure_code;
    public String failure_message;
    public Map<String, Object> fraud_details;
    public String invoice;
    public Boolean livemode;
    public Map<String, Object> metadata;
    public String on_behalf_of;
    public String order;
    public Outcome outcome;
    public Boolean paid;
    public String payment_intent;
    public String payment_method;
    public PaymentMethodDetails payment_method_details;
    public String receipt_email;
    public String receipt_number;
    public String receipt_url;
    public Boolean refunded;
    public String review;
    public Map<String, Object> shipping;
    public Source source;
    public String source_transfer;
    public String statement_descriptor;
    public String statement_descriptor_suffix;
    public String status;
    public Map<String, Object> transfer_data;
    public String transfer_group;
    public ErrorDetails error { get;  set; }

    public class BillingDetails {
        public Address address;
        public String email;
        public String name;
        public String phone;
    }
    public class ErrorDetails {
        public String code { get;  set; }
        public String doc_url { get;  set; }
        public String message { get;  set; }
        public String param { get;  set; }
        public String request_log_url { get;  set; }
        public String type { get;  set; }
    }

    public class Address {
        public String city;
        public String country;
        public String line1;
        public String line2;
        public String postal_code;
        public String state;
    }

    public class Outcome {
        public String network_status;
        public String reason;
        public String risk_level;
        public Integer risk_score;
        public String seller_message;
        public String type;
    }

    public class PaymentMethodDetails {
        public Card card;
        public String type;
    }

    public class Card {
        public Decimal amount_authorized;
        public String brand;
        public Checks checks;
        public String country;
        public Integer exp_month;
        public Integer exp_year;
        public ExtendedAuthorization extended_authorization;
        public String fingerprint;
        public String funding;
        public IncrementalAuthorization incremental_authorization;
        public Integer installments;
        public String last4;
        public String mandate;
        public Multicapture multicapture;
        public String network;
        public NetworkToken network_token;
        public Overcapture overcapture;
        public String three_d_secure;
        public String wallet;
    }

    public class Checks {
        public String address_line1_check;
        public String address_postal_code_check;
        public String cvc_check;
    }

    public class ExtendedAuthorization {
        public String status;
    }

    public class IncrementalAuthorization {
        public String status;
    }

    public class Multicapture {
        public String status;
    }

    public class NetworkToken {
        public Boolean used;
    }

    public class Overcapture {
        public Decimal maximum_amount_capturable;
        public String status;
    }

    public class Source {
        public String id;
        public String objectType;
        public String address_city;
        public String address_country;
        public String address_line1;
        public String address_line1_check;
        public String address_line2;
        public String address_state;
        public String address_zip;
        public String address_zip_check;
        public String brand;
        public String country;
        public String customer;
        public String cvc_check;
        public String dynamic_last4;
        public Integer exp_month;
        public Integer exp_year;
        public String fingerprint;
        public String funding;
        public String last4;
        public Map<String, Object> metadata;
        public String name;
        public String tokenization_method;
        public String wallet;
    }
}
