public with sharing class ReasonDescriptionController {
    public static final String ENDPOINT = 'https://official-joke-api.appspot.com/random_joke';
    public static final String METHOD = 'GET';

    @AuraEnabled
    public static void getReason(String recordId) {
        try{
            List<Case__c> caseToUpdate = [SELECT Id, ReasonDescription__c, AccountId__c, ReasonDetails__c FROM Case__c WHERE Id = :recordId LIMIT 1];
            if (caseToUpdate.isEmpty()) {
                return;
            }
            HttpResponse res = CalloutService.makeGetCallout(ENDPOINT,METHOD);
            if(res.getStatusCode() == 200){
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                String calloutResult = (String) results.get('punchline');
                if(RepeatRecordChecker.IsUnique(calloutResult, caseToUpdate[0].AccountId__c) && calloutResult != caseToUpdate[0].ReasonDetails__c){
                    caseToUpdate[0].ReasonDescription__c = calloutResult;
                }
            }
            update caseToUpdate;
        }catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
    }
}