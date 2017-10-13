# VERSION:		  0.1
# DESCRIPTION:	  Compile and run tor in a container
# AUTHOR:		  Sergi Blanch-Torne <sergi@calcurco.cat>
# COMMENTS:
#       A fork of jessfraz/tor repo, branch add-dockerfile, but with a
#       different way to think on it.
# USAGE:
#	# Build tor image
#	docker build -t tortoys:stretch .
#
#	# Run tor
#	docker run -d --net host --name tor --rm tortoys:stretch
#       # or see the console output with
#       docker run -i --net host --name tor --rm tortoys:stretch
#
#	# Run tor tests
#	docker run tortoys:stretch make check

# Base docker image
FROM debian:stretch

# Install dependencies
RUN apt-get update && apt-get install -y \
	asciidoc \
	automake \
	docbook-xsl \
	docbook-xml \
	gcc \
	g++ \
	libevent-dev \
	libminiupnpc-dev \
	libseccomp-dev \
	libssl-dev \
	make \
	xmlto \
	zlib1g-dev \
	--no-install-recommends \
	&& mkdir -p /usr/src/tor

ENV HOME /home/tor
RUN useradd --create-home --home-dir $HOME tor \
    && chown -R tor:tor $HOME


# Add source files
COPY . /usr/src/tor
WORKDIR /usr/src/tor

# Compile & install tor
RUN cd tor && \
    ./autogen.sh && \
    ./configure &&\
    make && \
    make install && \
    chown -R tor:tor /usr/src/tor ; \
    cd ..

RUN { \
    echo 'VirtualAddrNetworkIPv4 10.192.0.0/10'; \
    echo 'AutomapHostsOnResolve 1'; \
    echo 'TransPort 9040'; \
    echo 'DNSPort 5353'; \
} >  /etc/torrc && \
chown tor:tor /etc/torrc

USER tor

# set command as minimal default
CMD [ "/usr/local/bin/tor", "-f", "/etc/torrc" ]
