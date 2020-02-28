
# Running Nextflow with only Docker as dependency 


Nextflow/Nextflow container
data and nextflow script mounted in container
user taken from system 
makes use of sibling containers by mounting 


```
docker run -v /var/run/docker.sock:/var/run/docker.sock -u $(id -u):$(cut -d: -f3 < <(getent group docker)) -v $PWD:$PWD -w $PWD nextflow/nextflow nextflow run main.nf -with-docker
```