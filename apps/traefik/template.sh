#!/bin/bash

helm template traefik traefik/traefik --values=values.yaml  --output-dir . --include-crds
