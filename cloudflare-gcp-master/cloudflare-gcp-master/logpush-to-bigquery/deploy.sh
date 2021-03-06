#!/bin/sh

SCHEMA="schema-http.json"
BUCKET_NAME="f-cloudflare-cl-botmanagement"
DATASET="cloudflare_data"
TABLE="cloudflare_logs"
REGION="us-central1"
# You probably don't need to change this value:
FN_NAME="cloudflare_CL"

gcloud functions deploy $FN_NAME \
  --runtime nodejs10 \
  --trigger-resource $BUCKET_NAME \
  --trigger-event google.storage.object.finalize \
  --region=$REGION \
  --memory=1024MB \
  --entry-point=gcsbq \
  --set-env-vars DATASET=$DATASET,TABLE=$TABLE,SCHEMA=$SCHEMA
