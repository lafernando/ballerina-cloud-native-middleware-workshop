ballerina grpc --input calculator.proto --output stubs

ballerina new hash_service
cd hash_service
ballerina add service

cp ../stubs/calculator_pb.bal src/service/

calculator_service.bal
```ballerina
import ballerina/grpc;
import ballerina/crypto;

service HelloWorld on new grpc:Listener(9090) {

    resource function hello(grpc:Caller caller, string payload, grpc:Headers headers) returns error? {
        byte[] hash = crypto:hashMd5(payload.toBytes());
        grpc:Headers resHeader = new;
        check caller->send(hash.toBase16(), resHeader);
        check caller->complete();
    }
    
}
```
ballerina build -a
ballerina run target/bin/service.jar

ballerina new hash_client
cd hash_client/
ballerina add client
cp ../stubs/calculator_pb.bal src/client/

calculator_client.bal
```ballerina
import ballerina/grpc;
import ballerina/io;

public function main(string... args) returns error? {
    string payload = args[0];
    CalculatorBlockingClient calClient = new ("http://localhost:9090");
    grpc:Headers headers = new;
    var [result, resHeaders] = check calClient->hash(payload, headers);
    io:println(result);
}
```

ballerina build -a
ballerina run target/bin/client.jar "pojgwpreowohpoewrihjpwoeirhpweoirhpewoihwe"

