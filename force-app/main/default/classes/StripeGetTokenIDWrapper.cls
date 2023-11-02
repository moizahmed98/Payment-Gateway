public with sharing class StripeGetTokenIDWrapper {
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String objectType { get; set; } // Changed from "object" to "objectType"
    @AuraEnabled public Card card { get; set; }
    @AuraEnabled public String client_ip { get; set; }
    @AuraEnabled public Integer created { get; set; }
    @AuraEnabled public Boolean livemode { get; set; }
    @AuraEnabled public String type { get; set; }
    @AuraEnabled public Boolean used { get; set; }
 


     

    


public class Card {
    @AuraEnabled public String id { get; set; }
    @AuraEnabled public String objectType { get; set; } // Changed from "object" to "objectType"
    @AuraEnabled public String address_city { get; set; }
    @AuraEnabled public String address_country { get; set; }
    @AuraEnabled public String address_line1 { get; set; }
    @AuraEnabled public String address_line1_check { get; set; }
    @AuraEnabled public String address_line2 { get; set; }
    @AuraEnabled public String address_state { get; set; }
    @AuraEnabled public String address_zip { get; set; }
    @AuraEnabled public String address_zip_check { get; set; }
    @AuraEnabled public String brand { get; set; }
    @AuraEnabled public String country { get; set; }
    @AuraEnabled public String cvc_check { get; set; }
    @AuraEnabled public String dynamic_last4 { get; set; }
    @AuraEnabled public Integer exp_month { get; set; }
    @AuraEnabled public Integer exp_year { get; set; }
    @AuraEnabled public String funding { get; set; }
    @AuraEnabled public String last4 { get; set; }
    @AuraEnabled public String name { get; set; }
    @AuraEnabled public String tokenization_method { get; set; }
    @AuraEnabled public String wallet { get; set; }
}
 
}