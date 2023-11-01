public with sharing class AuthNetCustomerIDToCardInforWrapper 
{
    @AuraEnabled public String customerProfileId;
    @AuraEnabled public List<String> customerPaymentProfileIdList;
    @AuraEnabled public Messages messages;
    
    public class Messages {
        @AuraEnabled  public String resultCode;
        @AuraEnabled  public List<Message> message;
        }
    
        public class Message {
            @AuraEnabled public String code;
            @AuraEnabled public String text;

        }
}