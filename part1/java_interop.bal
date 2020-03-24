import ballerina/java;
import ballerina/io;

function uuid() returns handle = @java:Method {
    name: "randomUUID",
    class: "java.util.UUID"
} external;

function newDate() returns handle = @java:Constructor {
    class: "java.util.Date"
} external;

function getTime(handle receiver) returns int = @java:Method {
    class: "java.util.Date"
} external;

function setTime(handle receiver, int val) = @java:Method {
    class: "java.util.Date"
} external;

public function main() {
    io:println(uuid());
    handle date = newDate();
    io:println(getTime(date));
    setTime(date, 0);
    io:println(getTime(date));
}