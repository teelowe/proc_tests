#!/bin/bash

killProcessGroup() {
  echo "Killing process group id: $$"
  # de-register SIGTERM from the trap to avoid shell recursion (https://bugs.launchpad.net/ubuntu/+source/bash/+bug/1337827)
  # call kill with no options (--) on the negative (-) of the current pid, which kills the whole process group
  trap - SIGTERM && kill -- -$$
}

# call KillProcessGroup if any of these signals are trapped
trap killProcessGroup SIGCHLD SIGINT SIGTERM EXIT

./service.sh &
./sidecar.sh &

# set -m (monitor mode) ensures that new processes are launched in a separate process group
# if wait exits for any reason, we don't want it to trigger our trap
set -m
wait
# sets the shell back to interactive mode - i.e. new processes share the PGID of the parent process
set +m