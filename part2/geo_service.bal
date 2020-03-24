import ballerina/http;

http:Client clientEP = new ("https://freegeoip.app/");

service geoservice on new http:Listener(8080) {

    @http:ResourceConfig {
        path: "/geoip/{ip}"
    }
    resource function geoip(http:Caller caller, http:Request request, string ip) returns @tainted error? {
        http:Response resp = check clientEP->get("/json/" + <@untainted> ip);
        check caller->respond(<@untainted> check resp.getTextPayload());
    }

}