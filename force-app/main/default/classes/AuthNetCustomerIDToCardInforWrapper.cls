public class AuthNetCustomerIDToCardInforWrapper 
{
        public String customerProfileId;
        public List<String> customerPaymentProfileIdList;
        public Messages messages;
    
        public class Messages {
            public String resultCode;
            public List<Message> message;
        }
    
        public class Message {
            public String code;
            public String text;
        }
}