#!/bin/bash

source ./tests/sharedFuncs.sh

mockServiceDying() {
  a_pid=$(ps -ejf | grep "/bin/bash ./[s]ervice.sh" | awk '{print $2}')
  echo "PID of service is $a_pid"
  sleep 1
  echo "Grep for all processes in groupid $parent_pid"
  ps -ejf | grep "$parent_pid"
  sleep 5
  echo "killing service with PID $a_pid"
  kill "$a_pid"
}

# Assertions
# Run the service_init_mock.sh as if we were the PM
runServiceInitMock
parent_pid=$(getParentPID)
sleep 5
# Mock service dying as a child of service_init_mock
mockServiceDying
# Make sure we cleaned up all processes in this case
trap 'validateTest $parent_pid' SIGCHLD

set -m
wait
set +m