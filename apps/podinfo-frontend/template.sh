#!/bin/bash

STAGE=dev # TODO: replace with multi-env

### for creating further envs
## 1. create values file
# cp values-dev.yaml values-$STAGE.yaml

## 2. create directories
# mkdir $STAGE/manifests
# mkdir $STAGE/patches

## 3. create kustomization in stage
# cat <<EOF >$STAGE/kustomization.yaml
# apiVersion: kustomize.config.k8s.io/v1beta1
# kind: Kustomization

# resources:
# - ../base
# - manifests
# EOF


## 4. create kustomization in stage/manifests + adapt resources list if needed
# cat <<EOF >$STAGE/manifests/kustomization.yaml
# apiVersion: kustomize.config.k8s.io/v1beta1
# kind: Kustomization

# resources:
# - deployment.yaml
# - service.yaml
# EOF

# template helm chart into temp directory
mkdir tmp
helm template frontend podinfo/podinfo --values=values-$STAGE.yaml  --output-dir tmp --include-crds --skip-tests

# move files to right folder and delete tmp dir
mv tmp/podinfo/templates/* $STAGE/manifests
rmdir -p tmp/podinfo/templates
