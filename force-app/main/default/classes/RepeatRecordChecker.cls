public with sharing class RepeatRecordChecker {
    public static Boolean IsUnique(String result, Id accountId){
        List<Case__c> searchList = [SELECT Id FROM Case__c WHERE (ReasonDescription__c = :result OR ReasonDetails__c = :result) AND AccountId__c = :accountId];
        if (!searchList.isEmpty()) {
            return false;
        }
        return true;
     }
}