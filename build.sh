#!/bin/sh

# variables
namespace=airflow
release=cluster-airflow

# creating cluster
echo "Creating cluster..."
kind create cluster --image kindest/node:v1.21.1

# helm repo airflow
echo "Helm repo Airflow..."
helm repo add apache-airflow https://airflow.apache.org
helm repo update

# create namespace
echo "Creating namespace..."
kubectl create namespace $namespace

# installing airflow image on cluster
echo "Installing airflow..."
helm install $release apache-airflow/airflow -n airflow