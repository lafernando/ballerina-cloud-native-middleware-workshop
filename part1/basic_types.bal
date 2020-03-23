import ballerina/io;
public function main() {
    int a = 10;
    float b = 1.56;
    string c = "hello";
    var d = 20; // type inference with 'var' - 'd' is an int

    int[] intArray = [1, 2, 3, 4, 5, 6];
    int x = intArray.shift(); // similar to a dequeue operation
    io:println(x);
    x = intArray.pop();       // removes the last element
    io:println(x);
    intArray.push(10);        // add to the end
    io:println(intArray);

    // tuples - similar to a fixed length array with a distinct type for each slot
    // all the 
    [string, int] p1 = ["Jack", 1990]; 
    [string, int] p2 = ["Tom", 1986];
    io:println("Name: ", p1[0], " Birth Year: ", p1[1]);
    io:println("Name: ", p2[0], " Birth Year: ", p2[1]);

    string name1;
    int birthYear1;
    [name1, birthYear1] = p1;     // tuple destructuring

    var [name2, birthYear2] = p2; // declare and assign values in the same statement

    json j1 = { "name" : name1, "birthYear" : birthYear1, "zipcode" : 90210 };
    io:println(j1.name, " - ", j1.zipcode);
    var j2 = j1.mergeJson({ "id" : "90400593053"});
    io:println(j2);

    xmlns "http://example.com/ns1" as ns1;
    xmlns "http://example.com/default";
    
    xml x1 = xml `<ns1:entry><name>{{name1}}</name><birthYear>{{birthYear1}}</birthYear></ns1:entry>`;
    io:println(x1);
    io:println(x1/<name>);
    io:println(x1/*);
}