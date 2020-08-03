import ballerina/io;

type Person record {
    string name;
    int age;
};

type Result record {|
    string name;
    string college;
    int grade;
|};

public function main() {
    map<int> grades = {"Jack": 95, "Anne": 90, "John": 80, "Bill": 55};
    Person p1 = {name: "Jack", age: 30};
    Person p2 = {name: "John", age: 25};
    Person p3 = {name: "Anne", age: 17};
    Person p4 = {name: "Bill", age: 15};
    Person[] persons = [];
    persons.push(p1);
    persons.push(p2);
    persons.push(p3);
    persons.push(p4);

    Result[] results = from var person in persons
                        where lgrade > 75 
                            let int lgrade = (grades[person.name] ?: 0),
                            string targetCollege = "Stanford"
                            select { 
                                name: person.name, 
                                college: targetCollege, 
                                grade: lgrade 
                            };

    io:println(results);
}
