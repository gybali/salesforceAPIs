@isTest
public class TestDataFactory {
    public static Account createAccount() {
        Account testAccount = new Account(
            Name = 'Test Acc'
        );
        return testAccount;
    }
    public static Case__c createCase(Id accountId) {
        Case__c testCase = new Case__c(
            AccountId__c = accountId
        );
        return testCase;
    }
}