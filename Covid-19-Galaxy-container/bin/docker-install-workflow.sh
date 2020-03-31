#!/bin/bash

# install everything for workflow to work inside container

set -e
galaxy_instance="http://localhost:8080"

# launch the instance
echo "Starting Galaxy..."

export GALAXY_CONFIG_TOOL_PATH=/galaxy-central/tools/
startup_lite

# wait until galaxy has started
galaxy-wait -g $galaxy_instance

# run install as user galaxy
su - $GALAXY_USER

# install workflow
echo " - Extracting tools from workflows"
for w in `ls /workflowDir/*.ga | sort -r`
do
    echo $w
    workflow-to-tools -w $w -o /workflowDir/wftools.yaml -l "Tools from workflows"
    echo " - Installing tools from workflow" 
    n=0
    until [ $n -ge 3 ]
    do
        shed-tools install -t /workflowDir/wftools.yaml -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD && break
        n=$[$n+1]
        sleep 5
        echo " - Retrying shed-tools install "
    done    
    echo " - Installing workflow"
    workflow-install --publish_workflows --workflow_path $w -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD
    
done

echo "Installing extra tools" 
n=0
until [ $n -ge 3 ]
do
    shed-tools install -t tools.yaml -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD && break
    n=$[$n+1]
    sleep 5
    echo " - Retrying shed-tools install "
done        

echo "Checking for data libraries"
file="/data/data-library.yaml"
if [ -f "$file" ];
then    
    if [ "$(head -n 1 $file)" != "{}" ];
    then
        setup-data-libraries -i $file -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD -v
        echo "Data library installed"
    else
        echo "No data libraries to install"
    fi
else
    echo "No data libraries to install"
fi

# echo "Checking for data managers"
# if [ -f "/data/data-manager.yaml" ]
# then
#    echo " - Installing reference data"
#    run-data-managers --config "/data/data-manager.yaml" -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD
# else
#    echo " - No reference data to install"
# fi
