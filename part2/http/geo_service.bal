import ballerina/http;

http:LoadBalanceClient lbBackendEP = new ({
    targets: [
            {url: "http://example.com/ep1"},
            {url: "http://example.com/ep2"},
            {url: "http://example.com/ep3"}
        ],
    timeoutInMillis: 5000
});

http:FailoverClient foBackendEP = new ({
    timeoutInMillis: 5000,
    failoverCodes: [501, 502, 503],
    intervalInMillis: 5000,
    targets: [
            {url: "http://example.com/ep1"},
            {url: "http://example.com/ep2"},
            {url: "http://example.com/ep3"}
        ]
});

http:Client clientEP = new ("https://freegeoip.app/", {
            circuitBreaker: {
                rollingWindow: {
                    timeWindowInMillis: 10000,
                    bucketSizeInMillis: 2000,
                    requestVolumeThreshold: 0
                },
                failureThreshold: 0.2,
                resetTimeInMillis: 10000,
                statusCodes: [400, 404, 500]
            },

            timeoutInMillis: 2000,

            retryConfig: {
                intervalInMillis: 3000,
                count: 3,
                backOffFactor: 2.0,
                maxWaitIntervalInMillis: 20000
            }
        }
    );

service geoservice on new http:Listener(8080) {

    @http:ResourceConfig {
        path: "/geoip/{ip}"
    }
    resource function geoip(http:Caller caller, http:Request request, string ip) returns @tainted error? {
        http:Response resp = check clientEP->get("/json/" + <@untainted>ip);
        check caller->respond(<@untainted> check resp.getTextPayload());
    }

}
