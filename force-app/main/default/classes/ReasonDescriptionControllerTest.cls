@isTest
public class ReasonDescriptionControllerTest {
    @TestSetup
    static void makeData(){
        Account testAccount = TestDataFactory.createAccount();
        insert testAccount;

        Case__c testCase = TestDataFactory.createCase(testAccount.Id);
        insert testCase;
    }
    @isTest
    static void testGetReason(){
        Case__c testCase = [SELECT Id, ReasonDescription__c FROM Case__c LIMIT 1];

        Test.setMock(HttpCalloutMock.class, new HttpMockJokeCallout());

        Test.startTest();
        ReasonDescriptionController.getReason(testCase.Id);
        Test.stopTest();
        Case__c updatedCase = [SELECT Id, ReasonDescription__c FROM Case__c WHERE Id = :testCase.Id LIMIT 1];

        System.Assert.areNotEqual(testCase.ReasonDescription__c, updatedCase.ReasonDescription__c, 'Expected the ReasonDescriptionController.getReason to change ReasonDescription__c from Test Acc to a Joke.');
    }
}