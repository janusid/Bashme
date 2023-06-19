#!/bin/bash

# Define the image name
IMAGE_NAME="mybuilder"
#Define Container Name
NAME="BUILDER"

# Check number of container
i=$(( $(docker ps --format "{{.Names}}" | grep -c "$NAME") + 1 ))
  
# New Container Name
CONTAINER_NAME="${NAME}_$i"

# Run the container

docker run -d \
	--name "$CONTAINER_NAME" \
	--hostname DOCKER-DMC \
	--restart no \
	-v /DigiInstaller:/DigiInstaller \
	-v /home/dmc/.ssh:/root/.ssh \
	-w /home/dmc \
	--entrypoint "/bin/bash" \
	"$IMAGE_NAME" /home/dmc/dailybuild.sh

# Check status container
if [ $? -eq 0 ]; then
 echo "Container $CONTAINER_NAME is running."
else
 echo "Container $CONTAINER_NAME is not running."
fi