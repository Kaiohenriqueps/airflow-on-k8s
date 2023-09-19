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

## Guide

The following steps are necessary to create, build and/or destroy the cluster. See the script files for more information.

### How to create

```
$ ./build.sh
```

### How to deploy a custom image

```
$ ./deploy-image.sh
```

### How to destroy cluster

```
$ ./destroy-cluster.sh
```

### How to port forward to access UI

To access the UI, we need to user/password: admin/admin.

```
$ ./port-forward.sh
```
