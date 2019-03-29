#!/bin/bash

# launch the instance in deamon mode
echo "Starting Galaxy..."
startup &

galaxy_instance="http://localhost:8080"
galaxy-wait -g $galaxy_instance

python "/startingWorkflow.py"
