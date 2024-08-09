#!/usr/bin/env bash

# Filename: ~/github/scripts-public/macos/mac/015-dockerPsAllHosts.sh
# ~/github/scripts-public/macos/mac/015-dockerPsAllHosts.sh

# If you want to add or remove columns, put them inside /* */
# and remove the \t in the front \t{{.State}}{{/*.RunningFor*/}}

for node in docker1 docker2 docker3; do
  echo "************ $node ************"
  # https://docs.docker.com/reference/cli/docker/container/ls/#format
  ssh -o ConnectTimeout=2 $node 'docker ps --format "table {{.Names}}{{/*.Image*/}}\t{{.Status}}\t{{.State}}{{/*.RunningFor*/}}"'
  echo
done
