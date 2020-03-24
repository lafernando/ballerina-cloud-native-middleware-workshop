import ballerina/http;
import ballerina/system;

@http:ServiceConfig {
    basePath: "/"
}
service ChatAppUpgrader on new http:Listener(9090) {

    @http:ResourceConfig {
        webSocketUpgrade: {
            upgradePath: "/chat",
            upgradeService: chatApp
        }
    }
    resource function upgrader(http:Caller caller, http:Request req) returns error? {
        map<string[]> queryParams = req.getQueryParams();
        map<string> headers = {};
        http:WebSocketCaller wsEp = check caller->acceptWebSocketUpgrade(headers);
        string user = system:uuid();
        wsEp.setAttribute("user", user);
        check wsEp->pushText("User connected: " + user);
    }

}

map<http:WebSocketCaller> connectionsMap = {};

service chatApp = @http:WebSocketServiceConfig {} service {

    resource function onOpen(http:WebSocketCaller caller) returns error? {
        check broadcast(getAttributeStr(caller, "user") + " connected");
        connectionsMap[caller.getConnectionId()] = <@untainted>caller;
    }

    resource function onText(http:WebSocketCaller caller, string text) returns error? {
        string msg = getAttributeStr(caller, "user") + ": " + text;
        check broadcast(msg);
    }

    resource function onClose(http:WebSocketCaller caller, int statusCode, string reason) returns error? {
        _ = connectionsMap.remove(caller.getConnectionId());
        string msg = getAttributeStr(caller, "user") + " left the chat";
        check broadcast(msg);
    }
};

function broadcast(string text) returns error? {
    foreach var con in connectionsMap {
        check con->pushText(text);
    }
}

function getAttributeStr(http:WebSocketCaller ep, string key) returns (string) {
    return ep.getAttribute(key).toString();
}
