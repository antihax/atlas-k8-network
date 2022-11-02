#!/bin/sh
kubectl apply -f tools/mount-config-pv.yaml
kubectl delete configmap -natlas servergrid-files 
kubectl create configmap -natlas servergrid-files --from-file=./ServerGrid
kubectl wait pod -natlas atlas-cfg --for condition=Ready=True --timeout=90s
kubectl cp --retries=20 ./ServerGrid/ServerGrid/ atlas/atlas-cfg:/
kubectl delete -f tools/mount-config-pv.yaml