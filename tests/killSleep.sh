#!/bin/bash

source ./tests/sharedFuncs.sh

mockChildOfChildDying() {
  sleep_pid=$(ps -ejf | grep "[sleep] 25" | awk '{print $2}')
  echo "PID of service child sleep process is $sleep_pid"
  sleep 1
  echo "Grep for all processes in groupid $parent_pid"
  ps -ejf | grep "$parent_pid"
  sleep 5
  echo "Killing child sleep process of service with pid $sleep_pid"
  kill "${sleep_pid}"
}

# Assertions
# Run the service_init_mock as if we are the PM
runServiceInitMock
# Mock service_init being interacted with by PM
parent_pid=$(getParentPID)
sleep 5
mockChildOfChildDying
# Make sure we cleaned up all processes in this case
trap 'validateTest $parent_pid' SIGCHLD

set -m
wait
set +m