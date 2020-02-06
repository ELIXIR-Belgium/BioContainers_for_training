#!/usr/bin/env python
from bioblend.galaxy import GalaxyInstance
import sys
import time
import os
import json

# - Parameters
GALAXY_URL = 'http://localhost:80'
library_name = 'Local data'
history_name = 'History'
output_history_name = 'Output history'
outputDir = '/mountDir/outputData'
datamapping_file = '/mountDir/dataMapping.json'

# - Create Galaxy Instance Object
gi = GalaxyInstance(
    GALAXY_URL, email='admin@galaxy.org', password='admin')

# - Create history
gi.histories.create_history(name=history_name)
histories = gi.histories.get_histories(name=history_name)
history_id = histories[0]['id']
print('History ID: ' + history_id)

# - Create Library
# Default data is loaded from mounted directory
if sys.argv[1] == 'local':
    gi.libraries.create_library(name=library_name)
    libraries = gi.libraries.get_libraries(name=library_name)
    library_id = libraries[0]['id']
# when env variable datalibr is given, datalibrary already made with setup-data-libraries.
elif sys.argv[1] == 'datalibr':
    libraries = gi.libraries.get_libraries()
    library_id = libraries[0]['id']

print('Library ID: ' + library_id)

# - Upload mounted input data in library
gi.libraries.upload_file_from_server(library_id, './inputData')

# - Load data in history
files = gi.libraries.show_library(library_id, contents=True)
for f in files:
    if f['type'] == 'file':
        gi.histories.upload_dataset_from_library(history_id, f['id'])

# - Check for installed workflow
workflows = gi.workflows.get_workflows()
workflow_id = workflows[0]['id']
print('Workflow ID: ' + library_id)

# - Examine workflow
wf = gi.workflows.show_workflow(workflow_id)
print('Inputs workflow:' + str(wf['inputs']))


# - Determining input data
with open(datamapping_file, 'r') as f:
    dataset_namings = json.load(f)
datamap = dict()
for inputname in dataset_namings['inputs']:
    dataset = gi.histories.show_matching_datasets(
        history_id, name_filter=inputname['filename'])
    print('Input data step {}: '.format(
        inputname['step']) + dataset[0]['name'])
    datamap[inputname['step']] = {'src': 'hda', 'id': dataset[0]['id']}

# - Running workflow
gi.workflows.invoke_workflow(
    workflow_id, inputs=datamap, history_name=output_history_name)
print('Workflow invoked')
time.sleep(2)
output_histories = gi.histories.get_histories(name=output_history_name)
output_history_id = output_histories[0]['id']
print('Output history ID: ' + output_history_id)

while gi.histories.get_status(output_history_id)['percent_complete'] != 100:
    time.sleep(1)
    if gi.histories.get_status(output_history_id)['state_details']['error'] != 0:
        print('One of the steps in the workflow is giving an ERROR')
        break

print('Workflow Done.')

# - Export output files
output_files = gi.histories.show_history(
    output_history_id, contents=True,  visible=True)
for of in output_files:
    if of['history_content_type'] == 'dataset':
        print('Exporting ' + of['name'])
        gi.datasets.download_dataset(
            of['id'], file_path=outputDir)
