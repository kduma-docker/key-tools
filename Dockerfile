FROM ubuntu:22.04 AS builder

RUN apt-get update \
	&& apt-get -y install make gcc g++ cmake libfftw3-dev \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src

COPY . /usr/src

RUN make && make install
    
FROM ubuntu:22.04 AS runtime

RUN apt-get update \
	&& apt-get -y install libfftw3-dev \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /usr/local/bin/key /usr/local/bin/key-tag /usr/local/bin/
   
CMD ["/usr/local/bin/key", "-h"]