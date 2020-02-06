
# Running Nextflow with only Docker as dependency 


```
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:$PWD -w $PWD --user 1018 nextflow/nextflow bash nextflow main.nf -with-docker
```

