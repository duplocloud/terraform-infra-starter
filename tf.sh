#!/usr/bin/env bash

function tf() {
  echo "Running tf"
  local tf_args cmd var_cmds wksp_dir module_dir wksp module var_file
  var_cmds="apply destroy plan show validate state"
  tf_args="$*"
  cmd=$(tf-cmd "$tf_args")
  # re-export duplo creds as lowercase
  # export duplo_token=$(duploctl jit token --interactive --admin)
  export duplo_token=$DUPLO_TOKEN
  export duplo_host=$DUPLO_HOST
  if [ "$cmd" == "ctx" ]; then
    tf-ctx "$2"
  elif [ "$cmd" == "init" ]; then
    tf-init $tf_args
  else
    # if the cmd is one that needs the var file
    if [[ "$var_cmds" == *"$cmd"* ]]; then
      wksp_dir="$(tf-workspace-dir)"
      module_dir="$(tf-module-dir "$tf_args")"
      module="$(basename "$module_dir")"
      wksp="$(terraform -chdir="$module_dir" workspace show)"
      var_file="${wksp_dir}/${wksp}/${module}.tfvars"
      echo "Using var file: $var_file"
      # add the arg only if the file exists
      if [ -f "$var_file" ]; then
        tf_args+=" -var-file=$var_file"
      elif [ -f "${var_file}.json" ]; then
        tf_args+=" -var-file=${var_file}.json"
      fi
    fi
    echo "terraform $tf_args"
    terraform $tf_args
  fi
}

function tf-ctx() {
  local wksp_select wksp
  wksp_select="${1:-$(fzf --print-query <<< "$(terraform workspace list)" | tail -1)}"
  wksp="$(echo "$wksp_select" | tr -d '*' | tr -d '[:space:]')"
  terraform workspace select -or-create "$wksp"
}

# discover the variables for this workspace
function tf-workspace-dir() {
  if [ -z "$TF_WORKSPACE_DIR" ]; then
    dir=$(pwd)
    while [[ "$dir" != "/" ]]; do
      if [[ -d "$dir/config" ]]; then
        echo "$dir/config"
        break
      fi
      dir=$(dirname "$dir")
    done
  else 
    echo "$TF_WORKSPACE_DIR"
  fi
}

# find the terraform command
function tf-cmd() {
  for i in $1; do
    if [[ "$i" != -* ]]; then
      echo "${i#-}"
      break
    fi
  done
}

# find the working directory
function tf-module-dir() {
  local module_dir
  module_dir="$(pwd)"
  for i in $1; do
    if [[ "$i" == -chdir=* ]]; then
      module_dir="${module_dir}/${i#'-chdir='}"
      break
    fi
  done
  echo "$module_dir"
}

function tf-init() {
  BUCKET_PREFIX=duplo-tfstate
  PORTAL_INFO="$(duploctl system info --interactive --admin)"
  TF_ARGS=(
    -input=false
  )

  AWS_ENABLED="$(echo "$PORTAL_INFO" | jq -r '.IsAwsCloudEnabled')"
  GCP_ENABLED="$(echo "$PORTAL_INFO" | jq -r '.IsGoogleCloudEnabled')"
  AZURE_ENABLED="$(echo "$PORTAL_INFO" | jq -r '.IsAzureCloudEnabled')"

  echo "Portal info discovered"

  # configure the cloud environments
  if [[ "$AWS_ENABLED" == "true" ]]; then
    echo "Configuring AWS Backend"
    DUPLO_ACCOUNT_ID="$(echo "$PORTAL_INFO" | jq -r '.DefaultAwsAccount')"
    DUPLO_TF_BUCKET=${BUCKET_PREFIX}-${DUPLO_ACCOUNT_ID}
    AWS_DEFAULT_REGION="$(echo "$PORTAL_INFO" | jq -r '.DefaultAwsRegion')"
    TF_ARGS+=(
      "-backend-config=dynamodb_table=${DUPLO_TF_BUCKET}-lock"
      "-backend-config=region=$AWS_DEFAULT_REGION"
      "-backend-config=bucket=$DUPLO_TF_BUCKET"
    )
    echo "Your active configuration is: $DUPLO_ACCOUNT_ID"
  elif [[ "$GCP_ENABLED" == "true" ]]; then
    echo "Configuring GCP Backend"
    DUPLO_ACCOUNT_ID="$(gcloud config get project)"
    DUPLO_TF_BUCKET=${BUCKET_PREFIX}-${DUPLO_ACCOUNT_ID}
    TF_ARGS+=(
      "-backend-config=bucket=$DUPLO_TF_BUCKET"
    )
  elif [[ "$AZURE_ENABLED" == "true" ]]; then
    echo "Configuring Azure Backend"
    # if the RESOURCE_GROUP variable is not set, fail with error
    if [ -z "$RESOURCE_GROUP" ]; then
      echo "RESOURCE_GROUP is not set, please set the variable"
      exit 1
    fi
    DUPLO_TF_BUCKET=duplotfstate${DUPLO_ACCOUNT_ID}
    TF_ARGS+=(
      "-backend-config=storage_account_name=$DUPLO_TF_BUCKET"
    )
    ARM_ACCESS_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP --account-name $DUPLO_TF_BUCKET --query '[0].value' -o tsv)
  else
    echo "No cloud provider is enabled or authentication failed"
    exit 1
  fi
  # do the init
  echo "terraform $@ ${TF_ARGS[@]}"
  terraform "$@" "${TF_ARGS[@]}"
}
