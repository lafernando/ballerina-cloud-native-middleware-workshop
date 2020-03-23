import ballerina/lang.'int as ints;
import ballerina/io;

const FILE_ERROR = "FILE_ERROR";

type FileErrorDetail record {|
    string message?;
    error cause?;
    string path;
|};

type FileError error<FILE_ERROR, FileErrorDetail>;

public function main() {
    string input = io:readln("Enter number: ");
    int|error number = ints:fromString(input);
    if number is int {
        io:println("Number: ", number);
    } else {
        io:println("Invalid number: ", input);
    }

    error? err = fileOp();
    if err is FileError {
        io:println("Error: ", err);
    }
}

function fileOp() returns error? {
    return error(FILE_ERROR, path = "/etc/hosts");
}
