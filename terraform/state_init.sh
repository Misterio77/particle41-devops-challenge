#!/usr/bin/env bash
#
# This is script is used to bootstrap a S3 bucket for tf state/lock storage.
# After the imperative creation is complete, it will import the bucket into the
# tf state, so it's managed by terraform (woo recursion!)

set -euo pipefail

# Check dependencies
if ! aws="$(command -v aws)"; then
    echo "[ERR] This script requires AWS CLI, to create your S3 bucket" >&2
    exit 1
fi
if ! jq="$(command -v jq)"; then
    echo "[ERR] This script requires jq, for parsing regex" >&2
    exit 1
fi
if ! terraform="$(command -v terraform || command -v tofu)"; then
    echo "[ERR] This script requires either terraform or opentofu CLI" >&2
    exit 1
fi

if ! aws sts get-caller-identity > /dev/null;  then
    echo "[ERR] You're not authenticated to AWS. Set up an account and try 'aws configure'." >&2
    exit 1
fi

# Use bucket name provided on CLI, or prompt for it
if [ -n "${1:-}" ]; then
    bucket_name="$1"
else
    read -p "Type an unique name for the S3 state bucket: " bucket_name
    echo "" >&2
    if [ -z "${bucket_name:-}" ]; then
        exit 2
    fi
fi

# Check if it exists. If it doesn't, create it.
bucket="$(aws s3api list-buckets | jq -r --arg name "$bucket_name" '.Buckets[] | select(.Name == $name)')"
if [ -z "${bucket:-}" ]; then
    echo "[INFO] Creating bucket $bucket_name." >&2
    bucket="$(aws s3api create-bucket --bucket "$bucket_name")"
else
    echo "[INFO] Bucket $bucket_name already exists in your account, skipping creation." >&2
fi

# This is hardcoded to match the s3 tf backend in main.tf
export AWS_REGION="us-east-1"

# Initialize s3 backend
"$terraform" init -migrate-state -backend-config "bucket=$bucket_name" >&2

# If you want, you can manage the bucket itself with terraform
# Do keep in mind 'terraform destroy' might take your state with it, and risk
# leaving you with some dangling resources to be removed manually.
# "$terraform" import aws_s3_bucket.tfstate "$bucket_name" >&2
