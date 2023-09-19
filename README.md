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

## How to delete cluster

```
$ kind delete clusters --all
```

## How to run

First, you need to create the cluster, running the following command:

```
$ kind create cluster --name airflow
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

To create variables, you need to apply them:

```
$ kubectl create configmap airflow-variables --from-file=./variables.yaml
```

To upgrade some config in Airflow, we need to run the following command:

```
$ helm upgrade --install airflow apache-airflow/airflow -n airflow -f values.yaml --debug
```

In this case, I've changed the executor and the extraEnvFrom, so I needed to run the helm upgrade.

## How to enter in a pod

You need to run the following command:

```
$ kubectl exec --stdin --tty airflow-webserver-56d9cd6dcb-99glj -n airflow -- /bin/bash
```

### How to install dependencies

First, we need to create a requirements.txt and write on it all the dependencies that we need. Then, we have to create a Dockerfile with a airflow image and install the dependencies in the container.

```
$ docker build -t airflow-custom:1.0.0 .
```

Then, we have to load the image into our cluster.

```
$ kind load docker-image airflow-custom:1.0.0 --name airflow-cluster
```

Then, we have to modify (in values.yaml) the `defaultAirflowRepository` with the value (name) of our image (in this case, is airflow-custom) and we also have to change `defaultAirflowTag` with the tag (in this case, 1.0.0). Again, we have to upgrade:

```
$ helm upgrade --install airflow apache-airflow/airflow -n airflow -f values.yaml --debug
```

## How to check airflow info

You need to run the following command:

```
$ kubectl exec <webserver_name> -n airflow -- airflow info
```
