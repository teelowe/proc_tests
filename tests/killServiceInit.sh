#!/bin/bash

source ./tests/sharedFuncs.sh

mockParentDying() {
  echo "PID/GID of service_init process is $parent_pid"
  sleep 1
  echo "Grep for all processes in groupid $parent_pid"
  ps -ejf | grep "$parent_pid"
  sleep 5
  echo "Killing service_init with PID $parent_pid"
  kill "${parent_pid}"
}

# Assertions
# Run the service_init_mock.sh as if we were the PM
runServiceInitMock
# Mock service_init being killed by PM
parent_pid=$(getParentPID)
sleep 5
mockParentDying
# Make sure we cleaned up all processes in this case
trap 'validateTest $parent_pid' SIGCHLD

set -m
wait
set +m