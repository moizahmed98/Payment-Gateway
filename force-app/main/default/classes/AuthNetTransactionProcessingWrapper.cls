public  class AuthNetTransactionProcessingWrapper 
{
    @AuraEnabled
    public TransactionResponse transactionResponse { get; set; }
    @AuraEnabled
    public Messages messages { get; set; }

    public AuthNetTransactionProcessingWrapper() {
        // Initialize the nested lists to avoid null reference errors
        transactionResponse = new TransactionResponse();
        transactionResponse.messages = new List<Message>();
        
        messages = new Messages();
        messages.message = new List<Message>();
    }
    
    public class TransactionResponse {
        @AuraEnabled
        public String transId { get; set; }
        @AuraEnabled
        public List<Message> messages { get; set; }
    }
    
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
        public String description { get; set; }
        @AuraEnabled
        public String text { get; set; }
    }
}