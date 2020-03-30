# Covid-19 galaxy container

For more information on the workflows, please check https://github.com/galaxyproject/SARS-CoV-2


```
docker build -t quay.io/galaxy/covid-19-training -f Dockerfile .
docker run --privileged -p "8080:80" -t quay.io/galaxy/covid-19-training
docker login quay.io
docker push quay.io/galaxy/covid-19-training
```