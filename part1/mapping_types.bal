import ballerina/io;

public function main() {
    map<int> ageMap = {};
    ageMap["Peter"] = 25;
    ageMap["John"] = 30;

    int? agePeter = ageMap["Peter"]; // int? is the union type int|() - int or nill
    if agePeter is int {   // type test
        io:println("Peter's age is ", agePeter);
    } else {
        io:println("Peter's age is not found");
    }
}