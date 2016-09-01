FROM ubuntu:xenial
MAINTAINER hi@fael.nl
VERSION 1.0.0

RUN sh modules/core.sh
RUN sh modules/cplusplus.sh
RUN sh modules/julia.sh

RUN mkdir /root/.ssh
COPY ~/.ssh/id_dsa.pub /root/.ssh/
COPY ~/.ssh/id_dsa /root/.ssh/

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
COPY mycert.pem /root/mycert.pem
COPY mykey.key /root/mykey.key
EXPOSE 9999

CMD fish
