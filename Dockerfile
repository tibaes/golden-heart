FROM ubuntu:xenial
MAINTAINER hi@fael.nl

COPY modules/core.sh /tmp
RUN /tmp/core.sh

COPY modules/cplusplus.sh /tmp
RUN /tmp/cplusplus.sh

COPY modules/julia.sh /tmp
RUN /tmp/julia.sh

# RUN mkdir /root/.ssh
# COPY ~/.ssh/id_dsa.pub /root/.ssh/
# COPY ~/.ssh/id_dsa /root/.ssh/

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
COPY mycert.pem /root/mycert.pem
COPY mykey.key /root/mykey.key
EXPOSE 9999

CMD fish
