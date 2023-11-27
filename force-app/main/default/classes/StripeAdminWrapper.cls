public class StripeAdminWrapper {
    @AuraEnabled
    public String id { get; set; }
    @AuraEnabled
    public Settings settings;
    @AuraEnabled
    public Error error{ get;  set; }
    
    
    public class Settings {
        @AuraEnabled
        public Dashboard dashboard;
    }
    
    
    public class dashboard {
        @AuraEnabled
        public String display_name { get; set; }
    }
    
    public class Error {
        @AuraEnabled
        public String message;
        @AuraEnabled
        public String type;
    }
}