## PROC TESTS

A simple experiment to test various parent/child terminal process scenarios.  This was initially an experiment
to determine whether or not we could run a proxy sidecar as a child process of the parent service in a service mesh, as 
we were in an environment that required all services to be run by a service launcher which could only manage single processes.

### service.sh and sidecar.sh

simple sleep commands that simulate a service process and a sidecar process

### service_init_mock.sh

mocks the initialization of service and sidecar, backgrounds those processes and traps any interupting signals.

### tests directory

contains the tests for killing the various spawned processes and demonstrating that the entire process tree is terminated, regardless of which process in the tree is interrupted.

