# Best Practices for galaxy tutorial containers


## Building the Docker image image

To build the docker image, go to root of training repo

```docker build -t <your_tag> -f topics/<your_topic>/docker/Dockerfile .```

To run image:

```docker run -p "8080:80" -t <your_tag>```

