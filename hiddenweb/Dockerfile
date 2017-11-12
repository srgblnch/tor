# Base docker image
ARG DISTRO
ARG RELEASE
FROM $DISTRO:$RELEASE

# Install dependencies
RUN apt-get update && \
    apt-get dist-upgrade -y

ENV HOME /home/tor
RUN mkdir -p /usr/src/tor && \
    useradd --create-home --home-dir $HOME tor && \
    chown -R tor:tor $HOME

# Add source files
COPY thirdparty/tor /usr/src/tor
#WORKDIR /usr/src/tor

# Compile & install tor
RUN apt-get install -y --no-install-recommends \
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
        ntpdate && \
    cd /usr/src/tor && \
    ./autogen.sh && \
    ./configure &&\
    make && \
    make install && \
    chown -R tor:tor /usr/src/tor ; \
    cd .. ; \
    apt-get -y purge \
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
        ntpdate

# TODO: is necessary to compile also torsocks?

# Compile shallot
ADD thirdparty/Shallot /Shallot
RUN apt-get -y install \
        build-essential \
        #make \
        #autoconf \
        #automake \
        #libtool \
        #gcc \
        libssl-dev && \
    cd /Shallot && \
    ./configure && \
    make && \
    mv ./Shallot /bin && \
    cd / && \
    rm -Rf /Shallot && \
    apt-get -y purge \
        build-essential \
        #make \
        #autoconf \
        #automake \
        #libtool \
        #gcc \
        libssl-dev && \
    rm -Rf /var/lib/apt/lists/*

USER tor

# Prepare the nginx
RUN apt-get -y install \
    nginx

# Configure nginx logs to go to Docker log collection (via stdout/stderr)
RUN ln --symbolic --force /dev/stdout /var/log/nginx/access.log
RUN ln --symbolic --force /dev/stderr /var/log/nginx/error.log

# Main script
ADD hiddenweb/main.sh /main.sh

RUN { \
    echo 'DataDirectory /tmp/tor'; \
    echo 'HiddenServiceDir /web/'; \
    echo 'HiddenServicePort 80 127.0.0.1:8080'; \
    echo 'Log notice stdout'; \
    echo '#Log info'; \
    echo '#Log debug file @LOCALSTATEDIR@/log/tor/debug.log'; \
    } >  /etc/torrc && \
    chown tor:tor /etc/torrc

# Add nginx default configuration 
ADD hiddenweb/nginx.conf /etc/nginx/nginx.conf

# Configuration files and data output folder
VOLUME /web
WORKDIR /web

ENTRYPOINT ["/main.sh"]
CMD ["serve"]
