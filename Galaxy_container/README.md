# Automatic workflow loading and execution inside a galaxy container
Galaxy instance with tools from a workflow of interest shipped in a Docker container.
This workflow central approach to build a container enables automated deployment and execution of workflows in a cloud environment without the need for a GUI. Input and output data is mounted in the container and not part of it.

## Building the docker image
A Galaxy 19.01 container will be decorated with the necessary tools to run the workflow. 

### Check the DockerFile
A Dockerfile is like a recipe and contains all the commands to assemble an image. Place the inputfiles in a repository named `inputData` and
change the `GALAXY_CONFIG_LIBRARY_IMPORT_DIR` parameter in the DockerFile to the parent repository. Note that this parent repository will be mounted during the container run. In this example case the parent repository is named `mountDir` including the `inputData` repository.

Example:
```docker
ENV GALAXY_CONFIG_LIBRARY_IMPORT_DIR "/mountDir"
```

### Create a data mapping file

A data mapping file is a JSON file describing which file belongs to which input step of the workflow.

Example:

```json
{
    "inputs": [
        {
            "step":"0",
            "filename":"UCSC_input.bed"
        }
    ]
}
```

The attribute `inputs` contains a list of all the input files with their corresponding `filename` and workflow `step`. Note that the step number is in string format.

### Check the parameters of bin/startingWorkflow.py 
Open `bin/startingWorkflow.py` with an editor. Make sure that the paths toward the output directory and data mapping file described in previous paragraph are valid:

```python
outputDir = '/mountDir/outputData'
datamapping_file = '/mountDir/dataMapping.json'
```

To build the docker image use following command in the root directory:

```sh
docker build -t containername -f Dockerfile .
```


## Running the container

To run the container use following command:

```sh
docker run -p "8080:80" -t --mount type=bind,source="$(pwd)"/mountDir,target=/mountDir containername 
```

The `--mount` parameter consists of multiple key-value pairs describing the mount settings including type of mount, the source directory and the target directory within the container. Multiple `--mount` parameters can be used to mount more than one directory. Make sure these target directories correspond to the ones that are used in `bin/startingWorkflow.py` and `GALAXY_CONFIG_LIBRARY_IMPORT_DIR` in the DockerFile.