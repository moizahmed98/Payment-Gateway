public with sharing class GlobalPaymentAdminWrapper {

    public String token { get; set; }
    public String type { get; set; }
    public String error_code { get; set; }
    public String detailed_error_code { get; set; }
    public String detailed_error_description { get; set; }
    public class scope 
    {
        public String merchant_id { get; set; }
        public String merchant_name { get; set; }
    }

}