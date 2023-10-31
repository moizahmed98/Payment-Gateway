public with sharing class SquareAdminWrapper {
    
    public List<Merchant> merchant { get; set; }
    public List<Error> errors { get; set; }

    public class Merchant {
        public String id { get; set; }
        public String business_name { get; set; }
        public String country { get; set; }
        public String language_code { get; set; }
        public String status { get; set; }
        public String main_location_id { get; set; }
        public String owner_email { get; set; }
        public String created_at { get; set; }
    }

    public class Error {
        public String category { get; set; }
        public String code { get; set; }
        public String detail { get; set; }
    }

}