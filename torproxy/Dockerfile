# Base docker image
ARG DISTRO
ARG RELEASE
FROM $DISTRO:$RELEASE

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
COPY tor /usr/src/tor
#WORKDIR /usr/src/tor

# Compile & install tor
RUN cd /usr/src/tor && \
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
    echo '#Log info'; \
    echo '#Log debug file @LOCALSTATEDIR@/log/tor/debug.log'; \
    } >  /etc/torrc && \
    chown tor:tor /etc/torrc
# TODO: check to be sure the circuit is renew often enough

USER tor

# set command as minimal default
CMD [ "/usr/local/bin/tor", "-f", "/etc/torrc" ]
