#!/bin/bash

set -e  # Exit immediately if a command fails

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib unzip

echo "Creating database and user..."
sudo -u postgres psql <<EOF
CREATE DATABASE csye6225db;
CREATE USER csyeuser WITH ENCRYPTED PASSWORD 'csye6225pass';
GRANT ALL PRIVILEGES ON DATABASE csye6225db TO csyeuser;
EOF

echo "Creating Linux group and user..."
sudo groupadd csye6225 || echo "Group already exists"
sudo useradd -m -g csye6225 csyeuser || echo "User already exists"

echo "Unzipping application to /opt/csye6225..."
sudo mkdir -p /opt/csye6225
sudo unzip csye6225.zip -d /opt/csye6225

echo "Setting ownership and permissions..."
sudo chown -R csyeuser:csye6225 /opt/csye6225
sudo chmod -R 750 /opt/csye6225

echo "Setup complete."
