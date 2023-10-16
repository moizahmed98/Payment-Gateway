public with sharing class GlobalPayAdminWrapper {
    public String token { get; set; }
        public String type { get; set; }
        public Scope scope { get; set; }
        public String app_id { get; set; }
        public String app_name { get; set; }
        public String time_created { get; set; }
        public Integer seconds_to_expire { get; set; }
        public String email { get; set; }
        public String error_code { get; set; }
        public String detailed_error_code { get; set; }
        public String detailed_error_description { get; set; }
        
        public class Scope {
            public String merchant_id { get; set; }
            public String merchant_name { get; set; }
            public List<Account> accounts { get; set; }
        }
        
        public class Account {
            public String id { get; set; }
            public String name { get; set; }
            public List<String> permissions { get; set; }
        }
}