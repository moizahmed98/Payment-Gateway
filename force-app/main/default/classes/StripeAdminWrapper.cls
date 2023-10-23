public class StripeAdminWrapper {
    public String id { get; set; }
    public String objectType; // Rename the field
    public Map<String, Object> capabilities;
    public Boolean charges_enabled;
    public String country;
    public String default_currency;
    public Boolean details_submitted;
    public Boolean payouts_enabled;
    public Settings settings;
    public String type;
    public Error error{ get;  set; }
    
    public class Settings {
        public Map<String, Object> bacs_debit_payments;
        public Branding branding;
        public CardIssuing card_issuing;
        public CardPayments card_payments;
        public Dashboard dashboard;
        public Payments payments;
        public Payouts payouts;
        public Map<String, Object> sepa_debit_payments;
    }
    
    public class Branding {
        public String icon;
        public String logo;
        public String primary_color;
        public String secondary_color;
    }
    
    public class CardIssuing {
        public TosAcceptance tos_acceptance;
    }
    
    public class TosAcceptance {
        public String acceptanceDate; // Rename the field
        public String ip;
    }
    
    public class CardPayments {
        public String statement_descriptor_prefix;
        public String statement_descriptor_prefix_kana;
        public String statement_descriptor_prefix_kanji;
    }
    
    public class dashboard {
        public String display_name { get; set; }
        public String timezone;
    }
    
    public class Payments {
        public String statement_descriptor;
        public String statement_descriptor_kana;
        public String statement_descriptor_kanji;
    }
    
    public class Payouts {
        public Boolean debit_negative_balances;
        public Schedule schedule;
        public String statement_descriptor;
    }
    
    public class Schedule {
        public Integer delay_days;
        public String interval;
    }
    public class Error {
        public String message;
        public String type;
    }
}


