


```bash
Docker run –v /var/run/docker.sock:/var/run/docker.sock -v $PWD:$PWD  -w $PWD nextflow/nextflow bash nextflow main.nf -with docker
```