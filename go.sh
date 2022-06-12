#script to build and run jupyter in docker

#use a unique port in each project, so containers don't conflict on the host
port_to_run=8889

#if one is already running, stop it:
docker stop base_python

#build the custom docker image
docker build \
	--tag py310:latest \
	--label py310 \
	--build-arg HOSTUSER="$(whoami)" \
	.

#remove old builds if they exist
docker image prune --force --filter='label=py310'

#start the container + jupyter
docker run --rm -d \
	--publish $port_to_run:8888 \
        --name base_python \
        -v "$(pwd)":"/home/$(whoami)/hostmachine" \
        py310

# Initial browser window in order to generate token + cookie. Increase 2nd sleep if needed.
sleep 1
open http://localhost:$port_to_run
sleep 1

# extract jupyter token from docker container
token=$(docker exec base_python cat .local/share/jupyter/runtime/nbserver-1.json | grep token | sed 's/"token": "//' | sed 's/",//')

# Load app url using extracted token
open http://localhost:$port_to_run/?token="${token}"
