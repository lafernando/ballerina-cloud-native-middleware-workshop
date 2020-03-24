
## Kubernetes/Docker Deployment

@kubernetes:Deployment {
    image: "$env{docker_username}/geoservice",
    push: true,
    username: "$env{docker_username}",
    password: "$env{docker_password}",
    imagePullPolicy: "Always"
}

az aks get-credentials --resource-group connector --name k8stest1

## AWS Lambda Deployment

aws lambda create-function --function-name uuid --zip-file fileb://aws-ballerina-lambda-functions.zip --handler functions.uuid --runtime provided --role arn:aws:iam::908363916138:role/lambda-role --layers arn:aws:lambda:us-west-1:141896495686:layer:ballerina:2 --timeout 10 --memory-size 1024

aws lambda invoke --function-name uuid out.txt && cat out.txt

## GitHub Actions Samples

### Kubernetes Deployment
 - https://github.com/lafernando/ballerina-k8s-actions-sample

### Lambda Deployment
 - https://github.com/lafernando/lambda-actions-example

### Ballerina Central Deployment
 - https://github.com/lafernando/module-azurecv
