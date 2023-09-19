#!/bin/sh

# variables
namespace=airflow
release=cluster-airflow

kubectl port-forward svc/$release-webserver 8080:8080 -n $namespace