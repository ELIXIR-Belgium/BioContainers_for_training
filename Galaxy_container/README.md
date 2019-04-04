# Automatic workflow loading and execution inside a galaxy container




```sh
docker build -t containername -f Dockerfile .
```


```sh
docker run -p "8080:80" -t --mount type=bind,source="$(pwd)"/mountDir,target=/mountDir containername 
```

