# Best Practices for galaxy tutorial containers

## Requirements 

#### Recommended
* __tools.yaml__: describes the Tool Shed tools used in the tutorial
* __data-library.yaml__: describes the input datasets
* __workflows folder__: contains one or more workflows with all steps in the tutorial

#### Optional
* __data-manager.yaml__: describes the reference data required by tools
* __tours folder__: contains one or more yaml files describing interactive tours

## Format

```
---
api_key: admin
galaxy_instance: http://localhost:8080
install_tool_dependencies: True
install_repository_dependencies: True
install_resolver_dependencies: True

tools:
- name: tool1
  owner: owner
  revisions:
  - example
  tool_panel_section_label: "Section1"
  tool_shed_url: https://toolshed.g2.bx.psu.edu
- name: tool2
  owner: owner
  revisions:
  - example
  tool_panel_section_label: "Section2"
  tool_shed_url: https://toolshed.g2.bx.psu.edu
```




```
---
destination:
  type: library
  name: GTN - Material
  description: Galaxy Training Network Material
  synopsis: Galaxy Training Network Material. See https://training.galaxyproject.org
items:
- name: Title of the topic
  description: Summary of the topic
  items:
  - name: Title of the tutorial
    items:
    - name: 'DOI: 10.5281/zenodo....'
      description: latest
      items:
      - info: https://doi.org/10.5281/zenodo....
        url: https://zenodo.org/api/files/URL/to/the/input/file
        ext: galaxy-datatype
        src: url
```

## Installing tutorial requirements
We have created a small bash script to automatically install all of a tutorial’s requirements to an existing Galaxy. It’s located in this repository under: 

```bin/install_tutorial_requirements.sh```


## Building a Galaxy instance specifically for your training

To be able to run the tutorial, we need a Galaxy instance where all of the needed tools and data are available. Thus we need to describe the needed technical infrastructure.

This files we define in this tutorial will be used to automatically build a Docker Galaxy flavour, and also to test if a public Galaxy instance is able to run the tool.

In this tutorial, you will learn how to create a virtualised Galaxy instance, based on Docker, to run your training - either on normal computers or cloud environments.

## Building the Docker image image

To build the docker image, go to root of training repo

```docker build -t <your_tag> -f topics/<your_topic>/docker/Dockerfile .```

To run image:

```docker run -p "8080:80" -t <your_tag>```

