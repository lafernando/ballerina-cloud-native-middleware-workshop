```
ballerina grpc --input hashservice.proto --output stubs

ballerina new hash_service
cd hash_service
ballerina add service

cp ../stubs/hashservice_pb.bal src/service/
```

hash_service.bal
```ballerina
import ballerina/grpc;
import ballerina/crypto;

service HashService on new grpc:Listener(9090) {

    resource function hash(grpc:Caller caller, string payload, grpc:Headers headers) returns error? {
        byte[] hash = crypto:hashMd5(payload.toBytes());
        grpc:Headers resHeader = new;
        check caller->send(hash.toBase16(), resHeader);
        check caller->complete();
    }
    
}
```
```
ballerina build -a
ballerina run target/bin/service.jar

ballerina new hash_client
cd hash_client/
ballerina add client
cp ../stubs/hashservice_pb.bal src/client/
```

hash_client.bal
```ballerina
import ballerina/grpc;
import ballerina/io;

public function main(string... args) returns error? {
    string payload = args[0];
    HashServiceBlockingClient hashClient = new ("http://localhost:9090");
    grpc:Headers headers = new;
    var [result, resHeaders] = check hashClient->hash(payload, headers);
    io:println(result);
}
```
```
ballerina build -a
ballerina run target/bin/client.jar "pojgwpreowohpoewrihjpwoeirhpweoirhpewoihwe"
```

