public with sharing class StripeGetTokenIDWrapper {
    public String id { get; set; }
    public String objectType { get; set; } // Changed from "object" to "objectType"
    public Card card { get; set; }
    public String client_ip { get; set; }
    public Integer created { get; set; }
    public Boolean livemode { get; set; }
    public String type { get; set; }
    public Boolean used { get; set; }
 


     

    


public class Card {
    public String id { get; set; }
    public String objectType { get; set; } // Changed from "object" to "objectType"
    public String address_city { get; set; }
    public String address_country { get; set; }
    public String address_line1 { get; set; }
    public String address_line1_check { get; set; }
    public String address_line2 { get; set; }
    public String address_state { get; set; }
    public String address_zip { get; set; }
    public String address_zip_check { get; set; }
    public String brand { get; set; }
    public String country { get; set; }
    public String cvc_check { get; set; }
    public String dynamic_last4 { get; set; }
    public Integer exp_month { get; set; }
    public Integer exp_year { get; set; }
    public String funding { get; set; }
    public String last4 { get; set; }
    public String name { get; set; }
    public String tokenization_method { get; set; }
    public String wallet { get; set; }
}
 
}
