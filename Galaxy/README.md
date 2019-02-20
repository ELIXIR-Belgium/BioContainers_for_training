# Creating a new galaxy tutorial

For an in depth view on the specific steps in the creation of a new tutorial please visit:

- [Creating a new tutorial](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial/tutorial.html)
- [Defining the technical infrastructure](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial-technical/tutorial.html)
- [Creating Interactive Galaxy Tours](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial-tours/tutorial.html)
- [Slides](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial-slides/slides.html#1)
- [Writing content in Markdown](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial-content/tutorial.html)

## Genaral overview

1. __Determine the topic__\
   Please visit [Including a new topic](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-topic/tutorial.html) when the tutorial does not fit within one of the existing topics.
2. __Create your workflow on a running Galaxy instance__\
   If you need to install tools from the [toolshed](https://toolshed.g2.bx.psu.edu/) The tutorial is built around a workflow
3. __Create a Zenodo record with the input data__
   Reserve a Digital Object Identifier for your upload. 
4. __Generate the skeleton of your tutorial__
   - option 1: from a workflow located on a Galaxy
     ```
     $ planemo training_init \
            --topic_name "my-topic" \
            --tutorial_name "my-new-tutorial" \
            --tutorial_title "Title of the tutorial" \
            --galaxy_url "URL to Galaxy instance in which you created the workflow" \
            --galaxy_api_key "Your API key on the Galaxy instance" \
            --workflow_id "ID of the workflow on the Galaxy instance" \
            --zenodo_link "URL to the Zenodo record"
     ```
   - option 2: from a local workflow file (`.ga`)

     ```
     $ planemo training_init \
            --topic_name "my-topic" \
            --tutorial_name "my-new-tutorial" \
            --tutorial_title "Title of the tutorial" \
            --workflow "path/to/workflow" \
            --zenodo_link "URL to the Zenodo record"
     ```
     You can use the example workflow file located in `topics/contributing/tutorials/create-new-tutorial/workflows/example-workflow.ga` if
     you do not have a workflow of your own. This is the workflow belonging to the *Galaxy 101* introduction tutorial.

5. __Fill the remaining metadata and the content of the `tutorial.md`__\
   The most important file is the tutorial.md where the content of the tutorial is. The other files are there to support the tutorial and make it robust and usable across many environments.
6. __Creating the `data-library.yaml` file__
   - Copy the Zenodo link
   - Generate the data-library.yaml file and update the tutorial metadata with the link:
     ```
     $ planemo training_fill_data_library \
            --topic_name "my-topic" \
            --tutorial_name "my-new-tutorial" \
            --zenodo_link "URL to the Zenodo record"
     ```
   - Check that the data-library.yaml has been generated (or updated)
   - Check tha the Zenodo link is in the metadata at the top of the tutorial.md

## File structure in a topic

```
├── README.md
├── metadata.yaml
├── images
├── docker
│   ├── Dockerfile
├── slides
│   ├── index.html
├── tutorials
│   ├── tutorial1
│   │   ├── tutorial.md
│   │   ├── slides.html (optional)
│   │   ├── data-library.yaml
│   │   ├── workflows
│   │   │   ├── workflow.ga
│   │   ├── tours
│   │   │   ├── tour.yaml (optional)
```

## Building the Docker image

To build the docker image, go to root of the galaxy repository

```docker build -t <your_tag> -f topics/<your_topic>/docker/Dockerfile .```

## Running the Docker container

To run image:

```docker run -p "8080:80" -t <your_tag>```

