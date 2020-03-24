import ballerina/http;
import ballerina/kubernetes;

http:Client clientEP = new ("https://freegeoip.app/");

@kubernetes:Service {
    serviceType: "LoadBalancer",
    port: 80
}
@kubernetes:Deployment {
    image: "$env{docker_username}/geoservice",
    push: true,
    username: "$env{docker_username}",
    password: "$env{docker_password}",
    imagePullPolicy: "Always"
}
service geoservice on new http:Listener(8080) {

    @http:ResourceConfig {
        path: "/geoip/{ip}"
    }
    resource function geoip(http:Caller caller, http:Request request, string ip) returns @tainted error? {
        http:Response resp = check clientEP->get("/json/" + <@untainted>ip);
        check caller->respond(<@untainted> check resp.getTextPayload());
    }

}
