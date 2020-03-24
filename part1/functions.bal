import ballerina/io;

public function main() {
    int x = add(1, 2);
    io:println(x);
    io:println(multiply(2, 4));
    io:println(multiply(3, 4, true));
    io:println(addAll(1, 2, 3));
    io:println(addAll(1, 2, 3, 4, 5));

    // function pointers
    (function (int, int) returns int) op1 = getOperation("add");
    (function (int, int) returns int) op2 = getOperation("mod");
    io:println(op1(5, 10));
    io:println(op2(13, 10));

    // closures
    (function (int x) returns int) add5 = getAdder(5);
    (function (int x) returns int) add10 = getAdder(10);
    io:println(add5(10));
    io:println(add10(10));

    int[] numbers = [1, 2, 3, 4, 5, 6, 7, 8];
    // functional iteration
    int[] evenNumbers = numbers.filter(function (int x) returns boolean { return x % 2 == 0; });
    io:println(evenNumbers);
}

public function getOperation(string op) returns (function (int, int) returns int) {
    if op == "add" {
        return add;
    } else if op == "mod" {
        return function (int a, int b) returns int { // anonymous function
            return a % b;
        };
    } else {
        return (x, y) => 0; // single expression anonymous no-op function 
    }
}

// two required parameters
public function add(int a, int b) returns int {
    return a + b;
}

// 'log' is a defaultable parameter
public function multiply(int a, int b, boolean log = false) returns int {
    if log {
        io:println("Multiplying ", a, " with ", b);
    }
    return a * b;
}

public function addAll(int... numbers) returns int {
    int result = 0;
    foreach int number in numbers {
        result += number;
    }
    return result;
}

public function getAdder(int n) returns (function (int x) returns int) {
    return function (int x) returns int { // returns closure
        return x + n;
    };
}