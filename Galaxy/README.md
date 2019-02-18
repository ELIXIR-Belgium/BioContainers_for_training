# Making a new galaxy tutorial

1. Determine the topic
2. Create your workflow on a running Galaxy instance
3. Create a Zenodo record with the input data
4. Generate the skeleton of your tutorial
   - option 1: from a workflow located on a Galaxy
     ```
     $ planemo training_init \
            --topic_name "my-topic" \
            --tutorial_name "my-new-tutorial" \
            --tutorial_title "Title of the tutorial" \
            --galaxy_url "URL to Galaxy instance in which you created the workflow" \
            --galaxy_api_key "Your API key on the Galaxy instance" \
            --workflow_id "ID of the workflow on the Galaxy instance" \
            --zenodo_link "URL to the Zenodo record"
     ```
   - option 2: from a local workflow file (`.ga`)

     ```
     $ planemo training_init \
            --topic_name "my-topic" \
            --tutorial_name "my-new-tutorial" \
            --tutorial_title "Title of the tutorial" \
            --workflow "path/to/workflow" \
            --zenodo_link "URL to the Zenodo record"
     ```
     You can use the example workflow file located in `topics/contributing/tutorials/create-new-tutorial/workflows/example-workflow.ga` if
     you do not have a workflow of your own. This is the workflow belonging to the *Galaxy 101* introduction tutorial.

5. Fill the remaining metadata in the `tutorial.md`
6. Fill the content of the `tutorial.md`


## Building Docker image

To build the docker image, go to root of training repo

```docker build -t <your_tag> -f topics/<your_topic>/docker/Dockerfile .```

## Running Docker image

To run image:

```docker run -p "8080:80" -t <your_tag>```

