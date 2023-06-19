#!/bin/bash

# Define the image name
IMAGE_NAME="mybuilder"
#Define Container Name
NAME="BUILDER"

# Check number of container
i=$(( $(docker ps --format "{{.Names}}" | grep -c "$NAME") + 1 ))
  
# New Container Name
CONTAINER_NAME="${NAME}_$i"

#remove existitng container if any
docker rm "$CONTAINER_NAME" >/dev/null 2>&1

# Run the container
docker run -d \
	--name "$CONTAINER_NAME" \
	--hostname DOCKER-BUILDER \
	--restart no \
	-v /Installer:/Installer \
	-v /home/cnc/.ssh:/root/.ssh \
	-w /home/cnc \
	--entrypoint "/bin/bash" \
	"$IMAGE_NAME" /home/cnc/dailybuild.sh

# Check status container
if [ $? -eq 0 ]; then
 echo "Container $CONTAINER_NAME is running."
else
 echo "Container $CONTAINER_NAME is not running."
fi