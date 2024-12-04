trigger CaseTrigger on Case__c (before insert, before update, after insert, after update, after delete) {
    ServiceChangeHandler.runTrigger();
}