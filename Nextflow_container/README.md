
# Running Nextflow with only Docker as dependency 

This is a proof of concept using one of the [example](https://github.com/nextflow-io/rnaseq-nf) pipelines of Nextflow to demonstrate the Docker container only solution. The main container will be the official [Nextflow/Nextflow](https://hub.docker.com/r/nextflow/nextflow) container in which the directory with the input data and the Nextflow script will be mounted, as well as the Docker socket. Since the Docker socked of the host system is mounted, it is possible for the Nextflow container to run containers as siblings. The user within the Nextflow container is determent by the host system to prevent output files written as root.

Execute following command in the same directory as the Nextflow workflow file (in this example it will be the `nextflow_example` directory with `main.nf` being the Nextflow workflow file.):

### The magic command:

```
docker run -v /var/run/docker.sock:/var/run/docker.sock \
    -u $(id -u):$(cut -d: -f3 < <(getent group docker)) \
    -v $PWD:$PWD \
    -w $PWD \
    nextflow/nextflow \
    nextflow run main.nf -with-docker
```

### The command explained:

- `-v /var/run/docker.sock:/var/run/docker.sock` : Mounting the Docker socket of the host system inside the container.
- `-u $(id -u):$(cut -d: -f3 < <(getent group docker))`: Determining the host user + docker group for file permissions.
- `-v $PWD:$PWD`: Mounting the local folder structure including the input data, scripts and main workflow file.
- `nextflow/nextflow`: Container with workflow, will be pulled automatically if not already done.
- `nextflow run main.nf -with-docker`: The command executed in the Nextflow container. Replace `main.nf` by the name of your Nextflow workflow file.