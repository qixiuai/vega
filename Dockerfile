FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
	 ca-certificates \
         wget \
	 libjpeg-dev \
         g++ libgflags-dev unzip \
         libpng-dev && \
         rm -rf /var/lib/apt/lists/*

WORKDIR /home/guo

ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64:.:/home/guo/libtorch/lib
ENV PATH=/usr/local/cuda/bin:/usr/local/cuda/NsightCompute-2019.1${PATH:+:${PATH}}

RUN wget -nv --show-progress --progress=bar:force:noscroll https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh

RUN bash Anaconda3-2020.02-Linux-x86_64.sh -b

RUN rm Anaconda3-2020.02-Linux-x86_64.sh
ENV PATH /root/anaconda3/bin:$PATH

RUN conda install pytorch torchvision cudatoolkit=10.1 -c pytorch

RUN echo 'alias python="/root/anaconda3/bin/python"' >> ~/.bashrc

RUN echo 'alias pip="/root/anaconda3/bin/pip"' >> ~/.bashrc

RUN apt update && apt install -y emacs

RUN pip install flask opencv-python

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:.:/home/guo/libtorch/lib:${LD_LIBRARY_PATH}

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/cuda/lib64:.:/home/guo/libtorch/lib:${LD_LIBRARY_PATH}:/root/anaconda3/lib

ENV PATH /usr/bin:/usr/local/bin:$PATH




