#!/bin/bash

# ---- TENANT ACCOUNT ----
TENANT_USERNAME=$(op item get $TENANT_ACCOUNT_ID --vault "$OP_VAULT" --fields TENANT_USERNAME --reveal)
TENANT_PRIVATE_SSH_KEY=$(op item get $TENANT_ACCOUNT_ID --vault "$OP_VAULT" --fields TENANT_PRIVATE_SSH_KEY | tr -d '"')
TENANT_ADDRESS=$(op item get $TENANT_ACCOUNT_ID --vault "$OP_VAULT" --fields TENANT_ADDRESS)

# ---- BACKEND ACCOUNT ----
DATABASE_USER=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields DATABASE_USER --reveal)
DATABASE_PASSWORD=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields DATABASE_PASSWORD --reveal)
DATABASE_HOST=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields DATABASE_HOST --reveal)
DATABASE_PORT=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields DATABASE_PORT --reveal)
DATABASE_NAME=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields DATABASE_NAME --reveal)

APP_SECRET_KEY=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields APP_SECRET_KEY --reveal)

MIST_API_JWT_SECRET_KEY=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields MIST_API_JWT_SECRET_KEY --reveal)
MIST_API_JWT_AUDIENCES=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields MIST_API_JWT_AUDIENCES --reveal)
MIST_API_JWT_ISSUER=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields MIST_API_JWT_ISSUER --reveal)

APP_PORT=$(op item get $SERVICE_ACCOUNT_ID --vault "$OP_VAULT" --fields APP_PORT --reveal)

# Define file paths
KEY_FILE="key.pem"
INVENTORY_FILE="ansible/inventory/hosts.ini"

# Create ansible inventory directory and temporary file
mkdir -p ansible/inventory
touch $INVENTORY_FILE
echo "[mist-service]" >> "$INVENTORY_FILE"
echo $TENANT_ADDRESS >> "$INVENTORY_FILE"

# Create PRIVATE_SSH_KEY temporary file
touch $KEY_FILE
chmod 600 "$KEY_FILE"
echo -e "$TENANT_PRIVATE_SSH_KEY" >> "$KEY_FILE"


# Create tmporary environment variables file
touch .tmpenvs
echo "export TENANT_USERNAME=$TENANT_USERNAME" >> ".tmpenvs"

echo "export DATABASE_USER=$DATABASE_USER" >> ".tmpenvs"
echo "export DATABASE_PASSWORD=$DATABASE_PASSWORD" >> ".tmpenvs"
echo "export DATABASE_HOST=$DATABASE_HOST" >> ".tmpenvs"
echo "export DATABASE_PORT=$DATABASE_PORT" >> ".tmpenvs"
echo "export DATABASE_NAME=$DATABASE_NAME" >> ".tmpenvs"

echo "export APP_SECRET_KEY=$APP_SECRET_KEY" >> ".tmpenvs"

echo "export MIST_API_JWT_SECRET_KEY=\"$MIST_API_JWT_SECRET_KEY\"" >> ".tmpenvs"
echo "export MIST_API_JWT_AUDIENCES=\"$MIST_API_JWT_AUDIENCES\"" >> ".tmpenvs"
echo "export MIST_API_JWT_ISSUER=\"$MIST_API_JWT_ISSUER\"" >> ".tmpenvs"

echo "export APP_PORT=$APP_PORT" >> ".tmpenvs"

