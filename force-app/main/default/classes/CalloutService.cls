public with sharing class CalloutService implements Database.AllowsCallouts{
    public static HttpResponse makeGetCallout(String endpoint, String method){
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(endpoint);
            request.setMethod(method);
            HttpResponse response = http.send(request);
            return response;
        } catch (Exception ex) {
            System.debug(ex.getMessage());
            return null;
        }
    }
}