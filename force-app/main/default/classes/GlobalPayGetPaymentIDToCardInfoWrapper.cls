public with sharing class GlobalPayGetPaymentIDToCardInfoWrapper {
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String time_created { get; set; }
    @AuraEnabled public String status { get; set; }
    @AuraEnabled public String usage_mode { get; set; }
    @AuraEnabled public String merchant_id { get; set; }
    @AuraEnabled public String merchant_name { get; set; }
    @AuraEnabled public String account_id { get; set; }
    @AuraEnabled public String account_name { get; set; }
    @AuraEnabled public String reference { get; set; }
    @AuraEnabled public CardInfo card { get; set; }
    @AuraEnabled public ActionInfo action { get; set; }
    @AuraEnabled public String error_code { get; set; }
    @AuraEnabled public String detailed_error_code { get; set; }
    @AuraEnabled public String detailed_error_description { get; set; }

    public class CardInfo {
        @AuraEnabled public String masked_number_last4 { get; set; }
        @AuraEnabled public String brand { get; set; }
        @AuraEnabled public String expiry_month { get; set; }
        @AuraEnabled public String expiry_year { get; set; }
    }

    public class ActionInfo {
        @AuraEnabled public String id { get; set; }
        @AuraEnabled public String type { get; set; }
        @AuraEnabled public String time_created { get; set; }
        @AuraEnabled public String result_code { get; set; }
        @AuraEnabled public String app_id { get; set; }
        @AuraEnabled public String app_name { get; set; }
    }
}