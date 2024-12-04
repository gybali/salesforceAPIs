@isTest
public class RepeatRecordCheckerTest {
    @TestSetup
    static void makeData(){
        Account testAcc = TestDataFactory.createAccount();
        insert testAcc;

        Case__c testCase = TestDataFactory.createCase(testAcc.Id);
        Case__c testCase2 = TestDataFactory.createCase(testAcc.Id);
        testCase2.ReasonDescription__c = 'test';
        testCase.ReasonDetails__c = 'test3';
        insert new List<Case__c>{testCase, testCase2};
    }
    @IsTest
    static void testNoMatch(){
        Case__c testCase = [SELECT Id, AccountId__c, ReasonDescription__c FROM Case__c LIMIT 1];

        Test.startTest();
        Boolean result = RepeatRecordChecker.IsUnique('test2', testCase.AccountId__c);
        Test.stopTest();
        System.assertEquals(true, result);
    }
    @IsTest
    static void testMatch(){
        List<Case__c> testCases = [SELECT Id, AccountId__c, ReasonDescription__c FROM Case__c];

        Test.startTest();
        Boolean result = RepeatRecordChecker.IsUnique('test', testCases[0].AccountId__c);
        Test.stopTest();
        System.AssertEquals(false, result);
    }
}