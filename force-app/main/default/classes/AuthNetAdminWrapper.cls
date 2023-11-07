public with sharing class AuthNetAdminWrapper {

 
    @AuraEnabled
    public Messages messages { get; set; }

    public class Messages {
        @AuraEnabled
        public String resultCode { get; set; }
        @AuraEnabled
        public List<Message> message { get; set; }
    }

    public class Message {
        @AuraEnabled
        public String code { get; set; }
        @AuraEnabled
        public String text { get; set; }
    }
}