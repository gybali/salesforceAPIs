@isTest
global class HttpMockJokeCallout implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"setup": "testSetup", "punchline": "testPunchline"}');
        res.setStatusCode(200);
        return res;
    }
}