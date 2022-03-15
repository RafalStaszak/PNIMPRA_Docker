xhost +local:root
docker run -it --rm \
	--name=noetic \
	--shm-size=1g \
	--ulimit memlock=-1 \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix" \
	--volume="/home/$SUDO_USER/Shared:/root/Shared:rw" \
	--device=/dev/dri:/dev/dri \
	--env="DISPLAY=$DISPLAY" \
	--network=host \
	noetic \
	bash
