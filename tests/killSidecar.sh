#!/bin/bash

source ./tests/sharedFuncs.sh

mockSidecarDying() {
  b_pid=$(ps -ejf | grep "/bin/bash ./[s]idecar.sh" | awk '{print $2}')
  echo "PID of sidecar is $b_pid"
  sleep 1
  echo "Grep for all processes in groupid $parent_pid"
  ps -ejf | grep "$parent_pid"
  sleep 5
  echo "killing sidecar with PID $b_pid"
  kill "$b_pid"
}

# Assertions
# Run the service_init_mock.sh as if we were the PM
runServiceInitMock
parent_pid=$(getParentPID)
sleep 5
# Mock sidecar dying as a child of service_init_mock
mockSidecarDying
# Make sure we cleaned up all processes in this case
trap 'validateTest $parent_pid' SIGCHLD

set -m
wait
set +m