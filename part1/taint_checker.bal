import ballerina/io;

public function main(string... args) {
    mySecureFunction(<@untainted> args[0]);
    string s1 = "abc";
    mySecureFunction(s1);
    string s2 = <@tainted> s1;
    string s2x = s2 + "abc";
    //mySecureFunction(s2x);
}

public function mySecureFunction(@untainted string input) {
    io:println(input);
}