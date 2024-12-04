@IsTest
public class ServiceChangeHandlerTest {
    @TestSetup
    static void makeData(){
        Account acc = TestDataFactory.createAccount();
        insert acc;

        Case__c testCase = TestDataFactory.createCase(acc.Id);
        insert testCase;
    }

    @Istest
    static void testReasonChange(){
        Case__c testCase = [SELECT Id, Reason__c, ReasonDetails__c FROM Case__c LIMIT 1];
        Test.setMock(HttpCalloutMock.class,new HttpMockJokeCallout());

        Test.startTest();
        testCase.Reason__c = 'Service';
        update testCase;
        Test.stopTest();

        Case__c updatedCase = [SELECT Id, Reason__c, ReasonDetails__c FROM Case__c WHERE Id = :testCase.Id LIMIT 1];

        System.Assert.areNotEqual(testCase.ReasonDetails__c, updatedCase.ReasonDetails__c, 'Expected the ServiceChangeHandler.callout to change ReasonDetails__c from Test Acc to a Joke.');
    }
}