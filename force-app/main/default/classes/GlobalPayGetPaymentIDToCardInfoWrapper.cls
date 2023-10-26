public with sharing class GlobalPayGetPaymentIDToCardInfoWrapper {
    public String id { get; set; }
    public String time_created { get; set; }
    public String status { get; set; }
    public String usage_mode { get; set; }
    public String merchant_id { get; set; }
    public String merchant_name { get; set; }
    public String account_id { get; set; }
    public String account_name { get; set; }
    public String reference { get; set; }
    public CardInfo card { get; set; }
    public ActionInfo action { get; set; }
    public String error_code { get; set; }
    public String detailed_error_code { get; set; }
    public String detailed_error_description { get; set; }

    public class CardInfo {
        public String masked_number_last4 { get; set; }
        public String brand { get; set; }
        public String expiry_month { get; set; }
        public String expiry_year { get; set; }
    }

    public class ActionInfo {
        public String id { get; set; }
        public String type { get; set; }
        public String time_created { get; set; }
        public String result_code { get; set; }
        public String app_id { get; set; }
        public String app_name { get; set; }
    }
}