public with sharing class AuthNetAdminWrapper {
    public Messages messages { get; set; }

    public class Messages {
        public String resultCode { get; set; }
        public List<Message> message { get; set; }
    }

    public class Message {
        public String code { get; set; }
        public String text { get; set; }
    }
}