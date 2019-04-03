#!/bin/bash
set -e

# launch the instance in deamon mode
echo "Starting Galaxy"
startup &

galaxy_instance="http://localhost:8080"
galaxy-wait -g $galaxy_instance

echo "Loading workflow" 
python "/startingWorkflow.py" $1 
