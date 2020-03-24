import ballerina/http;

@http:ServiceConfig {
    basePath: "/"
}
service hello on new http:Listener(8080) {

    @http:ResourceConfig {
        path: "/hello"
    }
    resource function hi(http:Caller caller, http:Request request) returns error? {
        check caller->respond("Hello, World!");
    }

}