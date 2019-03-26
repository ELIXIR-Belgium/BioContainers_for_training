# install everything for all tutorials of a topic

set -e
galaxy_instance="http://localhost:8080"

# launch the instance
echo " - Starting Galaxy.. \n"

export GALAXY_CONFIG_TOOL_PATH=/galaxy-central/tools/
startup_lite

# wait until galaxy has started
galaxy-wait -g $galaxy_instance

# run tutorial install as user galaxy
su - $GALAXY_USER

# install other tutorial materials

echo " - Extracting tools from workflows"
for w in $dir/workflowsDir/*.ga
do
    workflow-to-tools -w $w -o $dir/workflows/wftools.yaml -l $(basename $dir)
    echo " - Installing tools from workflow $(basename $w)" 
    shed-tools install -t $dir/workflows/wftools.yaml -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD
    rm $dir/workflows/wftools.yaml
done
echo " - Installing workflows"
workflow-install --publish_workflows --workflow_path $dir/workflows/ -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD

echo "Finished installation of $dir tutorial \n"


cd /tutorials/
python /mergeyaml.py > ./data-library_all.yaml
# check if data-library_all.yaml is not empty
if [ "$(head -n 1 ./data-library_all.yaml)" != "{}" ];
then
    setup-data-libraries -i ./data-library_all.yaml -g $galaxy_instance -u $GALAXY_DEFAULT_ADMIN_USER -p $GALAXY_DEFAULT_ADMIN_PASSWORD -v
else
    echo "No data libraries to install"
fi
