#!/bin/bash

POD=$(kubectl get pod -A -lmicroservice=SelfService -ojsonpath='--namespace {.items[0].metadata.namespace} {.items[0].metadata.name}')
kubectl port-forward $POD 7681
