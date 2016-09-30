FROM phusion/baseimage

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm"

RUN apt-get update && apt-get install -y --no-install-recommends gdebi-core usbutils ca-certificates-mono wget && apt-get clean -y

RUN wget --quiet --no-cookies -O /tmp/homegenie.deb https://github.com/genielabs/HomeGenie/releases/download/v1.1-beta.525/homegenie-beta_1.1.r525_all.deb

RUN gdebi --non-interactive /tmp/homegenie.deb 

RUN mkdir /etc/service/homegenie

ADD homegenie.runit /etc/service/homegenie/run

RUN chmod +x /etc/service/homegenie/run

# cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

VOLUME /usr/local/bin/homegenie
