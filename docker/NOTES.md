```
aws ecr create-repository --repository-name rails-app --region eu-central-1
docker build -t 637423538949.dkr.ecr.eu-central-1.amazonaws.com/rails-app .
docker push 637423538949.dkr.ecr.eu-central-1.amazonaws.com/rails-app

aws ecr create-repository --repository-name content-api --region eu-central-1
docker build -t 637423538949.dkr.ecr.eu-central-1.amazonaws.com/content-api .
docker push 637423538949.dkr.ecr.eu-central-1.amazonaws.com/content-api

aws ecr create-repository --repository-name worker --region eu-central-1
docker build -t worker:latest 637423538949.dkr.ecr.eu-central-1.amazonaws.com/worker .
docker push 637423538949.dkr.ecr.eu-central-1.amazonaws.com/worker
```
### ----- Not used ----
Was implemented for tests with Docker for AWS ECR. In Helm and Kubernetes container is used from central repository of postgres
```
aws ecr create-repository --repository-name postgres --region eu-central-1
docker build -t postgres:latest 637423538949.dkr.ecr.eu-central-1.amazonaws.com/postgres .
docker push 637423538949.dkr.ecr.eu-central-1.amazonaws.com/postgres
```