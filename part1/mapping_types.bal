import ballerina/io;

type Person record {
    string name;
    int age;
};

// Student is a subtype of Person
type Student record {
    string name;
    int age;
    string college?;
};

type Scores record {
    int physics;
    int mathematics;
};

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

    Person p1 = { name : "Anne", age: 28 };
    io:println(p1);

    Scores s1 = { physics : 80, mathematics: 95 };
    s1["chemistry"] = 75;
    io:println(s1);
    io:println(s1["chemistry"]);

    Student st1 = { name : "Jack", age: 25 };
    st1.college = "Stanford";
    string? jacksCollege = st1?.college; // optional field access
    if jacksCollege is string {
        io:println("Jack's college is ", jacksCollege);
    }
    Person p2 = st1;
}