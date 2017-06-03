#
# A Dockerfile with pip3, python3, keras 2.x with TensorFlow bas backend,tensorboard and jupyter
# Also clones and sets up python modules needed for MuGo repo we are using to learn about AlphaGo
#
#
# https://hub.docker.com/r/gw000/keras/
FROM gw000/keras:2.0.4-py3
# for GPU use 2.0.4-gpu

MAINTAINER vamsee@onkore.com

# install additional python packages
RUN pip3 --no-cache-dir install \
    # jupyter notebook and ipython (Python 3)
    ipython \
    ipykernel \
    jupyter \
    # data analysis (Python 3)
    pandas \
    scikit-learn \
    statsmodels \
 && python3 -m ipykernel.kernelspec


# for jupyter
EXPOSE 8888
# for tensorboard
EXPOSE 6006

RUN mkdir /home/ml
WORKDIR /home/ml
RUN git clone https://github.com/brilee/MuGo
RUN cd MuGo && pip3 install -r requirements.txt

CMD /bin/bash -c 'jupyter notebook --no-browser --ip=*  "$@"'

# build it
# docker build -t vamsee/keras-tf .
# run it like this to access jupyter notebook from outside docker (no bash)
# docker run -it  -p=6006:6006 -p=8888:8888 -v /Users/vamsee/Development/ml/projects/ml-docker/notebooks:/notebooks vamsee/keras-tf
# or like this for immediate bash shell access
# docker run -it  -p=6006:6006 -p=8888:8888 -v /Users/vamsee/Development/ml/projects/ml-docker/notebooks:/notebooks vamsee/keras-tf /bin/bash
#
# if you don't want to use the mount, copy the data files like this:
# docker cp  go 4478a445f50a:/home/ml

# Misc tests
# python3 -c "import keras; print(keras.__version__)"
# -->Using TensorFlow backend.
# -->2.0.4
# python3 -c 'import tensorflow as tf;  print(tf.__version__);'
# -->1.1.0
# tensorboard --logdir logs
