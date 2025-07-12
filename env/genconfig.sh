#!/bin/bash

CONFIGMAP_NAME="difyai-config"
NAMESPACE="difyai"
ENV_FILE=".env.example"

echo "apiVersion: v1"
echo "kind: ConfigMap"
echo "metadata:"
echo "  name: ${CONFIGMAP_NAME}"
echo "  namespace: ${NAMESPACE}"
echo "data:"

grep -v '^[[:space:]]*#' "$ENV_FILE" | grep -v '^[[:space:]]*$' | grep '=' | while IFS='=' read -r key value; do
    key=$(echo "$key" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    value=$(echo "$value" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
    safe_value=$(printf "%s" "$value" | sed 's/\\/\\\\/g; s/\"/\"/g')
    echo "  $key: \"$safe_value\""
done
