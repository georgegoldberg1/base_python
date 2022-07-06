# README for Base Python Docker  

Builds ubuntu docker container, installing pip requirements for python and running jupyter notebook in your local browser.

Maps this repo folder into Docker so you can create and save notebooks and then git push outside of docker afterwards.

# Setup:

### Build and start container  
`bash go.sh`

### Stop container  

Easiest way to stop the jupyter container is to click "Quit" in the top right (next to "log out") in the jupyter main file browser window.

If you have already closed the browser without quitting jupyter, use the command line to stop the docker container:

`bash stop.sh`  

OR: 

`docker stop base_python`

note: each time you run `bash go.sh`, it will stop the container that is currently running, so be careful running it if you havent saved changes in notebooks.

### Remove all stopped containers
`docker container rm $(docker ps -aq)`

## Optional:requirements.txt
You can change the packages in requirements.txt
After you run the container, it's recommended to do a pip freeze on the package versions, so this build will hold for future. Python version should be included too ideally.


## Version details
- python3.10 currently in ubuntu 22.04)  
- Works on MacOS and MacOS Apple Silicon.  
- Updated July2022

## Author
George Goldberg
