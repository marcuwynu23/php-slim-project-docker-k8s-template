@echo off
@REM ============================= Docker and Docker compose ===============================================
@REM Buld Image using docker-compose
docker-compose build

@REM Test Docker Image by creating temporary container
docker run -it --rm -p 8080:8080 myslimapp:latest
curl http://localhost:8080
@REM if it good now you can push that image in dockerhub, need to login first
@REM if already login then a tag:
docker tag myslimapp:latest marcuwynu23/myslimapp:latest
@REM then push
docker push marcuwynu23/myslimapp:latest


@REM ============================= Kubernetes Cluster =====================================================
@REM NOTE: you need to have minikube installed and also already start minikube
@REM Create K8s Deployment of that image
kubectl create deployment myslimapp --image=marcuwynu23/myslimapp:latest --port=8080 --replicas=3
@REM Create K8s Service for that deployment
kubectl expose deployment --service=LoadBalancer --port=80 --target-port=8080 --name=myslimapp-svc
@REM Check Pods
kubectl get Pods

@REM if the status of pods is running then run minikube tunnel to expose the ip, if not then
@REM check pod status by kubectl describe pod "pod_name"


@REM test deployed
@REM to get the ip address using minikube ip then to get the port use the kubectl get pods 
curl http://172.25.101.190:32323

@REM to delete deployment
kubectl delete deployment myslimapp
@REM to delete service
kubectl delete svc  myslimapp-svc