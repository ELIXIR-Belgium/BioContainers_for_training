
# Galaxy - Title of the topic
#
# to build the docker image, go to root of training repo and
#    docker build -t example_topic -f topics/example_topic/docker/Dockerfile .
#
# to run image:
#    docker run -p "8080:80" -t example_topic

FROM bgruening/galaxy-stable:latest

MAINTAINER Galaxy Training Material

ENV GALAXY_CONFIG_BRAND "Galaxy Container"

# prerequisites
RUN pip install ephemeris -U
ADD bin/galaxy-sleep.py /galaxy-sleep.py

# copy the tutorials directory for your topic
ADD /data-library.yaml /workflowDir/data-library.yaml
ADD /workflows /workflowDir

# install everything for tutorials
ADD bin/docker-install-tutorials.sh /setup-tutorials.sh
ADD bin/mergeyaml.py /mergeyaml.py
RUN /setup-tutorials.sh
