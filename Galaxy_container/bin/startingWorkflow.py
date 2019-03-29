#!/usr/bin/env python
from bioblend.galaxy import GalaxyInstance
from bioblend.galaxy.histories import HistoryClient
from bioblend.galaxy.tools import ToolClient
from bioblend.galaxy.workflows import WorkflowClient

GALAXY_URL = 'http://localhost:8080'
workflow_name = 'GTN - Sequence analyses - Quality control'
history_name = 'Hystory'
dataset_name_1 = 'Ecoli_C_assembly.fna'


gi = GalaxyInstance(
    GALAXY_URL, email='admin@galaxy.org', password='admin')


gi.histories.create_history(name=history_name)
gi.libraries.create_library(name='Local data')
gi.libraries.upload_file_from_server('f2db41e1fa331b3e', './inputData')

toolClient = ToolClient(gi)
toolClient = ToolClient(gi)
workflowsClient = WorkflowClient(gi)

histories_out = gi.histories.get_histories(name=history_name)
history_id = histories_out[0]['id']
dataset_1 = gi.histories.show_matching_datasets(history_id,name_filter=dataset_name_1)

workflows = workflowsClient.get_workflows(name = workflow_name)
workflow = workflows[0]
print(workflows[0])
datamap = {}
datamap['0'] = { 'src':'hda', 'id':dataset_1[0]['id'] }
w= workflowsClient.invoke_workflow(workflow['id'], datamap, history_id=history_id) 

print(history_id)

gi.libraries.show_library('f2db41e1fa331b3e')
gi.workflows.get_workflows()
