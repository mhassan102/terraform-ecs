# Dockerfile to use as a base for python
#
# https://github.com/wtsi-hgi/docker-ubuntu-python-pip

FROM ubuntu:14.04
MAINTAINER "Joshua C. Randall" <jcrandall@alum.mit.edu>

# Prerequisites
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y python python-pip python-dev



# add cron scripts and make executable
RUN mkdir /home/testing
ADD testcron.py /home/testing/testcron.py
ADD cronrun.sh /home/testing/cronrun.sh
RUN chmod +x /home/testing/cronrun.sh

# cron schedule
ADD mycrontab /home/testing/mycrontab
RUN crontab /home/testing/mycrontab

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
