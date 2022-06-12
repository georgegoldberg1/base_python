#script to build and run jupyter in docker

port_to_run=8889

docker stop base_python

docker build \
	--tag py310:latest \
	--label py310 \
	--build-arg HOSTUSER="$(whoami)" \
	.

docker image prune --force --filter='label=py310'

#open http://localhost:8889

#docker run --rm -i \
docker run --rm -d \
	--publish $port_to_run:8888 \
        --name base_python \
        -v "$(pwd)":"/home/$(whoami)/hostmachine" \
        py310

# Initial browser window in order to generate token + cookie
sleep 1
open http://localhost:$port_to_run
sleep 1

# extract jupyter token from docker container
token=$(docker exec base_python cat .local/share/jupyter/runtime/nbserver-1.json | grep token | sed 's/"token": "//' | sed 's/",//')

# Load app url using extracted token
open http://localhost:$port_to_run/?token="${token}"
