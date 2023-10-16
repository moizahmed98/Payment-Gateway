public  class AuthNetTransactionProcessingWrapper 
{
    public TransactionResponse transactionResponse { get; set; }
    public Messages messages { get; set; }
    
    public class TransactionResponse {
        public String transId { get; set; }
        public List<Message> messages { get; set; }
    }
    
    public class Messages {
        public String resultCode { get; set; }
        public List<Message> message { get; set; }
    }
    
    public class Message {
        public String code { get; set; }
        public String description { get; set; }
        public String text { get; set; }
    }
}