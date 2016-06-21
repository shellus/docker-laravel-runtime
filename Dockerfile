# ------------------------------------------------------------------------------
# Docker provisioning script for the docker-laravel web server stack
#
# 	e.g. docker build -t mtmacdonald/docker-laravel:version . 
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Start with the official Ubuntu 14.04 base image
# ------------------------------------------------------------------------------

FROM ubuntu:14.04

MAINTAINER Mark Macdonald <mark.t.macdonald@googlemail.com>

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Use Supervisor to run and manage all other services



# ------------------------------------------------------------------------------
# Provision the server
# ------------------------------------------------------------------------------

RUN mkdir /provision
ADD provision /provision

ADD run.sh /run.sh
RUN chmod 775 /*.sh

RUN /provision/provision.sh


# ------------------------------------------------------------------------------
# Prepare image for use
# ------------------------------------------------------------------------------
# Add VOLUMEs to allow backup of config and databases
VOLUME  ["/var/lib/mysql"]

# Expose ports
EXPOSE 80
EXPOSE 22

CMD ["/run.sh"]
# ------------------------------------------------------------------------------
# Set locale (support UTF-8 in the container terminal)
# ------------------------------------------------------------------------------

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# ------------------------------------------------------------------------------
# Clean up
# ------------------------------------------------------------------------------

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*