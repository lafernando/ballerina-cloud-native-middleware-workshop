import ballerina/io;
import ballerina/http;

http:Client webep = new("http://example.com");

public function main() {
    doWorkers();
    doFuture();
}

public function doFuture() {
    future<int> f10 = start fib(10);
    var result = webep->get("/");
    int x = wait f10;
    if result is http:Response {
        io:println(result.getTextPayload());
        io:println(x);
    }
}

function fib(int n) returns int {
    if n <= 2 {
        return 1;
    } else {
        return fib(n - 1) + fib(n - 2);
    }
}

public function doWorkers() {
    worker w1 returns int {
        int j = 10;
        j -> w2;
        int b;
        b = <- w2;
        return b * b;
    }
    worker w2 returns int {
        int a;
        a = <- w1;
        a * 2 -> w1;
        return a + 2;
    }
    record {int w1; int w2;} x = wait {w1, w2};
    io:println(x);
}

