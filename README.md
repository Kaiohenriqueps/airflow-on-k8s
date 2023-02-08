# airflow-on-k8s
Project to run Airflow on Kubernetes.

## Requisites
Install the following packages:
```
$ brew install kind
$ brew install helm
$ brew install kubectl
```

Install Docker and Docker compose.

## How to run
First, you need to create the cluster, running the following command:
```
$ kind create cluster --name airflow-cluster --config kind-cluster.yaml
```

Checking if the cluster is running and stable:
```
$ kubectl cluster-info
$ kubectl get nodes -o wide
```

Then we have to create the airflow namespace
```
$ kubectl create namespace airflow
```
And after that, we have to collect the airflow helm:
```
$ helm repo add apache-airflow https://airflow.apache.org
$ helm repo update
$ helm search repo airflow
$ helm install airflow apache-airflow/airflow --namespace airflow --debug
```

In another terminal, we can see the pods running with the command:
```
$ kubectl get pods -n airflow
```

To connect in airflow UI, we need to user the port-forward:
```
$ kubectl port-forward svc/airflow-webserver 8080:8080 -n airflow --context kind-airflow-cluster
```