#!/bin/sh

echo "Destroying cluster..."
kind delete clusters --all
echo "Cluster destroyed!"