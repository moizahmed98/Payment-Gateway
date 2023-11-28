public with sharing class APILogsManager {
    
// Function to fill API logs data
public static void fillAPILogsData(String gatewayType, String action, String url, 
                                String requestBody, String responseBody, String status) {
if (requestBody.length() > 131072) 
{
    requestBody = requestBody.substring(0, 131072);
}
if (responseBody.length() > 131072) 
{
    responseBody = responseBody.substring(0, 131072);
}
logicpayment__API_Logs__c apiLog = new logicpayment__API_Logs__c();
apiLog.Name = gatewayType+'-'+action;
apiLog.logicpayment__Gateway_Type__c = gatewayType;
apiLog.logicpayment__Action__c = action;
apiLog.logicpayment__URL__c = url;
apiLog.logicpayment__Request_Body__c = requestBody;
apiLog.logicpayment__Response_Body__c = responseBody;
apiLog.logicpayment__Status__c = status;

// Insert the API log record
insert apiLog;
}
}
