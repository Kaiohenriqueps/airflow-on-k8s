#!/bin/sh

# variables
namespace=airflow
release=cluster-airflow

# creating the airflow image using the Dockerfile
echo "Building image..."
docker build -f docker/Dockerfile -t airflow-custom:1.0.0 .

# loading into cluster
echo "Loading image into cluster..."
kind load docker-image airflow-custom:1.0.0

# upgrade helm deployment
# TODO: completar as variáveis do Airflow, seguindo o que tem no docker-compose
echo "Upgrading..."
helm upgrade $release apache-airflow/airflow -n $namespace \
    --set images.airflow.repository=airflow-custom \
    --set images.airflow.tag=1.0.0 \
    --set-string "env[0].name=AIRFLOW__CORE__EXECUTOR" \
    --set-string "env[0].value=CeleryExecutor" \
    --set-string "env[1].name=AIRFLOW__CORE__LOAD_EXAMPLES" \
    --set-string "env[1].value=False"

echo "Upgrade completed!"