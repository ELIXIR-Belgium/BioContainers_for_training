# Creating a new galaxy tutorial

For an in depth view on the specific steps in the creation of a new tutorial please visit:

- [Creating a new tutorial](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial/tutorial.html)
- [Defining the technical infrastructure](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial-technical/tutorial.html)
- [Creating Interactive Galaxy Tours](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial-tours/tutorial.html)
- [Slides](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial-slides/slides.html#1)
- [Writing content in Markdown](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-tutorial-content/tutorial.html)

### 1. Determine the topic
Please visit [Including a new topic](https://galaxyproject.github.io/training-material/topics/contributing/tutorials/create-new-topic/tutorial.html) when the tutorial does not fit within one of the existing topics.


### 2. Create your workflow on a running Galaxy instance

If you need to install tools from the [toolshed](https://toolshed.g2.bx.psu.edu/). The tutorial is built around a workflow

### 3. Create a Zenodo record with the input data

Reserve a Digital Object Identifier for your upload. 


### 4. Genarate the file structure using planemo

#### The file structure

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


#### Install planemo

`Planemo` can be easaly installed using `pip`.  

```
pip install planemo
```

#### Generate the skeleton of your tutorial
- Option 1: from a workflow located on a Galaxy instance
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
- Option 2: from a local workflow file (`.ga`)

     ```
     $ planemo training_init \
            --topic_name "my-topic" \
            --tutorial_name "my-new-tutorial" \
            --tutorial_title "Title of the tutorial" \
            --workflow "path/to/workflow" \
            --zenodo_link "URL to the Zenodo record"
     ```

Fill the remaining metadata and the content of the `tutorial.md`

#### Creating the `data-library.yaml` file

   - Generate the data-library.yaml file and update the tutorial metadata with the link:
     ```
     $ planemo training_fill_data_library \
            --topic_name "my-topic" \
            --tutorial_name "my-new-tutorial" \
            --zenodo_link "URL to the Zenodo record"
     ```
   - Check that the data-library.yaml has been generated (or updated)
   - Check tha the Zenodo link is in the metadata at the top of the tutorial.md

### Using Docker to built a Galaxy training container

#### Built the Docker image

Open a terminal, go to the root of the galaxy repository (in this example `./Galaxy`) and use following command:

```
docker build -t <your_tag> -f topics/<your_topic>/docker/Dockerfile .
```

Where `<your_tag>` is the name of the image and `<your_topic>` is the name of the topic.

#### Running the Docker container

To execute the image, use following command:

```
docker run -p "8080:80" -t <your_tag>
```

#### Using the running Galaxy container

Open a webbrowser and go to `http://localhost:8080`.