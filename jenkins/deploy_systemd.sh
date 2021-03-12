#!/bin/bash

# Install application to /opt/
sudo rm -r /opt/todo-list
sudo mkdir /opt/todo-list
sudo cp -r . /opt/todo-list

# Generate service file
cat << EOF > todo-list.service
[Unit]
Description=Todo List

[Service]
DATABASE_URI = "34.105.147.232"
SECRET_KEY = "hjghdjkfhgkjdfhgkjdhfg"
MYSQL_USER='root'
MYSQL_PASSWORD='root'
sudo bash jenkins/setup.sh
# Systemd service configuration here
# You'll need to set these environment variables:
#     DATABASE_URI
#     SECRET_KEY
# 
# Use the jenkins/setup.sh script to start the app
# 
# Attach the user either to jenkins or (preferably) 
# dedicated service user, e.g. pythonadm
# ----------------------------------
# Configuration here!
# ----------------------------------

[Install]
WantedBy=multi-user.target
EOF

# Move service file to systemd
sudo cp todo-list.service /etc/systemd/system/todo-list.service

# systemd reload/start/stop
sudo systemctl daemon-reload
sudo systemctl stop todo-list
sudo systemctl start todo-list
