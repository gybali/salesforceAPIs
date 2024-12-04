public with sharing class ServiceChangeHandler {
    public static final String ENDPOINT = 'https://official-joke-api.appspot.com/random_joke';
    public static final String METHOD = 'GET';

    public static void runTrigger(){
        if(Trigger.isAfter && Trigger.isUpdate) {
            setReasonDetails(Trigger.new,(Map<Id,Case__c>) Trigger.oldMap);
        }
    }
    private static void setReasonDetails(List<Case__c> newCases, Map<Id, Case__c> oldCases){
        try {
            for (Case__c c : newCases) {
                if (c.Reason__c == 'Service' && c.Reason__c != oldCases.get(c.Id).Reason__c) {
                    doCallout(c.Id, c.AccountId__c);
                }
            }
        } catch (Exception ex) {
            System.debug(ex.getLineNumber()+' ' + ex.getMessage());
        }
    }
    @future (callout=true)
    private static void doCallout(Id caseId, Id accountId){
        HttpResponse res = CalloutService.makeGetCallout(ENDPOINT, METHOD);
        if (res.getStatusCode() == 200) {
            Case__c newCase = new Case__c(
                Id = caseId
            );
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            String calloutResult = (String) results.get('setup');
            if (RepeatRecordChecker.IsUnique(calloutResult, accountId)) {
                newCase.ReasonDetails__c = calloutResult;
            }
            update newCase;
        }
    }
}