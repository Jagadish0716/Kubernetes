# Kubernetes Learning Repo

This repository is dedicated to **learning** and **experimenting** with Kubernetes (`k8s`).  
It contains notes, manifests, and examples for setting up and running applications inside Kubernetes using **Minikube**.

---

## Prerequisites

Before starting, make sure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

---

## Minikube & Docker Integration

By default, Docker builds images in your local environment.  
With **Minikube**, you can build images **inside Minikube’s Docker daemon**, so you don’t need to push them to Docker Hub.

### Step 1: Show Docker Environment Variables
```bash
minikube docker-env
```
This command outputs something like:
```bash
ubuntu@ip-172-31-32-212:~$ minikube docker-env
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.49.2:2376"
export DOCKER_CERT_PATH="/home/ubuntu/.minikube/certs"
export MINIKUBE_ACTIVE_DOCKERD="minikube"

# To point your shell to minikube's docker-daemon, run:
# eval $(minikube -p minikube docker-env)
```
### Step 2: Point Shell to Minikube’s Docker
```bash
eval $(minikube -p minikube docker-env)
```
Now when you run:
```bash
docker ps
```
or 
```bash
docker image ls
```
you’ll see containers running inside Minikube.

