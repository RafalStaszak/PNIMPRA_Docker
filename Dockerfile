FROM osrf/ros:noetic-desktop-full
MAINTAINER Rafal Staszak <staszak.raf@gmail.com>
RUN echo "Europe/Utc" > /etc/timezone
# RUN ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime
RUN apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends tzdata
RUN dpkg-reconfigure -f noninteractive tzdata
# Install packages
RUN apt-get update -q && \
	export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends apt-utils software-properties-common wget curl rsync netcat mg vim bzip2 zip unzip && \
    apt-get install -y --no-install-recommends libxtst6 && \
    apt-get install -y --no-install-recommends bash-completion && \
    apt-get install -y --no-install-recommends nano && \ 
    apt-get install -y --no-install-recommends net-tools && \
    apt-get install -y --no-install-recommends iputils-ping && \
    apt-get install -y --no-install-recommends terminator && \
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update -q && \
        export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y --no-install-recommends install libgl1-mesa-glx libgl1-mesa-dri && \
    apt-get install mesa-utils && \
    rm -rf /var/lib/apt/lists/*
RUN sed -i 's/--no-generate//g' /usr/share/bash-completion/completions/apt-get && \
    sed -i 's/--no-generate//g' /usr/share/bash-completion/completions/apt-cache
WORKDIR /root/

RUN sed -i "s/#force_color_prompt=yes/force_color_prompt=yes/g" /root/.bashrc

RUN echo 'if [ -f /etc/bash_completion ] && ! shopt -oq posix; then \n\
    . /etc/bash_completion \n\
fi \n\
\n\
export USER=root \n\
source /opt/ros/$ROS_DISTRO/setup.bash' >> /root/.bashrc

RUN touch /root/.Xauthority
