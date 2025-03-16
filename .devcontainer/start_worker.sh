#!/bin/bash

# Run by devcontainer's 'postAttachCommand'
#
# Updates headnode hostname from GitHub, creates new SSH configuration file
# and opens SSH tunnel to hdeadnode on port 7077. Then starts Spark worker
# process

mkdir -p ~/.ssh
git pull
gh codespace ssh -c `cat .headnode_hostname` --config > ~/.ssh/config
ssh -vfN -L 7077:localhost:7077 cs.`cat .headnode_hostname`.main
sudo /opt/spark/sbin/start-worker.sh localhost:7077 --webui-port 8080
