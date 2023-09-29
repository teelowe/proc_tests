#!/bin/bash

runServiceInitMock() {
  set -m
  bash -c ./service_init_mock.sh &
  set +m
}

getParentPID() {
  ps -ejf | grep "[s]ervice_init_mock.sh" | awk '{print $2}'
}

validateTest() {
  local parent_pid=$1

  result=$(ps -ejf | awk '{print $4}' | grep "${parent_pid}")
  # check result is a zero string
  test -z "$result" && echo "Tests Passed! No remaining PGID process found"
  echo "Visual check for processes still running in groupid $parent_pid"
  ps -ejf | grep "$parent_pid"
}