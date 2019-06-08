
# Galaxy - Title of the topic
#
# to build the docker image, go to root of training repo and
#    docker build -t example_topic -f topics/example_topic/docker/Dockerfile .
#
# to run image:
#    docker run -p "8080:80" -t example_topic

FROM bgruening/galaxy-stable:19.01
MAINTAINER Galaxy Training Material

ENV GALAXY_CONFIG_BRAND "Galaxy Container"
ENV GALAXY_CONFIG_LIBRARY_IMPORT_DIR "/mountDir"


ADD bin/galaxy-sleep.py /galaxy-sleep.py
ADD bin/startingWorkflow.py /startingWorkflow.py
ADD bin/docker-install-workflow.sh /setup-workflow.sh
ADD bin/starter-service.sh /starter-service.sh
ADD /dataLibrary /workflowDir/
ADD /workflow /workflowDir

RUN pip install ephemeris -U
RUN /setup-workflow.sh

ENTRYPOINT ["/starter-service.sh"]
CMD ["local"]