import ballerina/time;
import ballerina/io;

type Person object {
    
    private int birthYear;
    public string name;

    public function __init(string name, int birthYear) {
        self.birthYear = birthYear;
        self.name = name;
    }

    public function age() returns int {
        time:Time ct = time:currentTime();
        return time:getYear(ct) - self.birthYear;
    }

};

public function main() {
    Person p1 = new("Jack", 1986);
    io:println("Age of ", p1.name, " is ", p1.age());
}