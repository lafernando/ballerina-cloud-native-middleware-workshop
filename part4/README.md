
## Kubernetes/Docker Deployment

@kubernetes:Deployment {
    image: "$env{docker_username}/geoservice",
    push: true,
    username: "$env{docker_username}",
    password: "$env{docker_password}",
    imagePullPolicy: "Always"
}

az aks get-credentials --resource-group connector --name k8stest1

## GitHub Actions Samples

### Kubernetes Deployment
 - https://github.com/lafernando/ballerina-k8s-actions-sample

### Lambda Deployment
 - https://github.com/lafernando/lambda-actions-example

### Ballerina Central Deployment
 - https://github.com/lafernando/module-azurecv
