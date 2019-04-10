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
for w in /workflowDir/*.ga
do
    echo $w
    workflow-to-tools -w $w -o /workflowDir/wftools.yaml -l "Tools from workflows"
    echo " - Installing tools from workflow" 
    shed-tools install -t /workflowDir/wftools.yaml -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD
    
done
echo " - Installing workflows"
    workflow-install --publish_workflows --workflow_path /workflowDir/ -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD

echo "Finished installation of workflow"


# check if data-library_all.yaml is not empty
echo "Checking for data libraries"
file="/workflowDir/data-library.yaml"
if [ -f "$file" ];
then    
    if [ "$(head -n 1 $file)" != "{}" ];
    then
        setup-data-libraries -i $file -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD -v
        echo "Data library installed"
    else
        echo "No data libraries to install"
    fi
fi
