FROM debian:bullseye-slim

RUN adduser --disabled-password --gecos "" --no-create-home --uid 1000 cronos

RUN mkdir -p /home/cronos
RUN mkdir -p /home/cronos/bin/
RUN chown -R cronos:cronos /home/cronos
RUN apt-get update -y && apt-get install wget curl procps net-tools htop lz4 -y
RUN cd /tmp && wget --no-check-certificate https://github.com/crypto-org-chain/cronos/releases/download/v0.8.1/cronos_0.8.1-rocksdb_Linux_x86_64.tar.gz && tar -xvf cronos_0.8.1-rocksdb_Linux_x86_64.tar.gz \
    && mv bin/cronosd /home/cronos/bin/cronosd && mv lib /home/cronos/bin/ && mv exe /home/cronos/bin/
RUN chown -R cronos:cronos /home/cronos
USER cronos

ENTRYPOINT ["/home/cronos/bin/cronosd"]
