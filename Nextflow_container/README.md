
# Running Nextflow with only Docker as dependency 


Most simple way of running the 


```
docker run -v /var/run/docker.sock:/var/run/docker.sock -u $(id -u):$(cut -d: -f3 < <(getent group docker)) -v $PWD:$PWD -w $PWD nextflow/nextflow nextflow run main.nf -with-docker
```