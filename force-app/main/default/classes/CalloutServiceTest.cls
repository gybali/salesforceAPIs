@isTest
public class CalloutServiceTest {
    public static final String ENDPOINT = 'https://official-joke-api.appspot.com/random_joke';
    public static final String METHOD = 'GET';

    @IsTest
    public static void testCallout() {
        Test.setMock(HTTPCalloutMock.class, new HttpMockJokeCallout());
        Test.startTest();
        HttpResponse res = CalloutService.makeGetCallout(ENDPOINT, METHOD);
        Test.stopTest();
        
        System.Assert.areEqual(200, res.getStatusCode());
    }

}