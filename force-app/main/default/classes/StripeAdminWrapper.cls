public class StripeAdminWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public String objectType; // Rename the field
    @AuraEnabled
    public Map<String, Object> capabilities;
    @AuraEnabled
    public Boolean charges_enabled;
    @AuraEnabled
    public String country;
    public String default_currency;
    public Boolean details_submitted;
    public Boolean payouts_enabled;
    @AuraEnabled
    public Settings settings;
    public String type;
    @AuraEnabled
    public Error error{ get;  set; }
    
    
    public class Settings {
        @AuraEnabled
         public Map<String, Object> bacs_debit_payments;
         @AuraEnabled
         public Branding branding;
         @AuraEnabled
         public CardIssuing card_issuing;
         @AuraEnabled
         public CardPayments card_payments;
        @AuraEnabled
        public Dashboard dashboard;
        @AuraEnabled
        public Payments payments;
        @AuraEnabled
        public Payouts payouts;
        @AuraEnabled
        public Map<String, Object> sepa_debit_payments;
    }
    
    public class Branding {
        @AuraEnabled
        public String icon;
        @AuraEnabled
        public String logo;
        @AuraEnabled
        public String primary_color;
        @AuraEnabled
        public String secondary_color;
    }
    
    public class CardIssuing {
        @AuraEnabled
        public TosAcceptance tos_acceptance;
    }
    
    public class TosAcceptance {
        @AuraEnabled
        public String acceptanceDate; // Rename the field
        @AuraEnabled
        public String ip;
    }
    
    public class CardPayments {
        @AuraEnabled
        public String statement_descriptor_prefix;
        @AuraEnabled
        public String statement_descriptor_prefix_kana;
        @AuraEnabled
        public String statement_descriptor_prefix_kanji;
    }
    
    
    public class dashboard {
        @AuraEnabled
        public String display_name { get; set; }
        @AuraEnabled
        public String timezone;
    }
    
    public class Payments {
        @AuraEnabled
        public String statement_descriptor;
        @AuraEnabled
        public String statement_descriptor_kana;
        @AuraEnabled
        public String statement_descriptor_kanji;
    }
    
    public class Payouts {
        @AuraEnabled
        public Boolean debit_negative_balances;
        @AuraEnabled
        public Schedule schedule;
        @AuraEnabled
        public String statement_descriptor;
    }
    
    public class Schedule {
        @AuraEnabled
        public Integer delay_days;
        @AuraEnabled
        public String interval;
    }
    
    public class Error {
        @AuraEnabled
        public String message;
        @AuraEnabled
        public String type;
    }
}