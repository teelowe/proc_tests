#!/bin/bash

# Run all the tests!!!

cat << EOF
----------------------------------------------------
PM killing the service_init script
----------------------------------------------------
EOF
./tests/killServiceInit.sh
sleep 3
echo

cat << EOF
----------------------------------------------------
service dying under the supervision of the PM
----------------------------------------------------
EOF
./tests/killService.sh
sleep 3
echo

cat << EOF
----------------------------------------------------
sidecar dying under the supervision of the PM
----------------------------------------------------
EOF
./tests/killSidecar.sh
sleep 3
echo

cat << EOF
----------------------------------------------------
exit of a child process of a service
----------------------------------------------------
EOF
./tests/killSleep.sh
