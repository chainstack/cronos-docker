FROM debian:bullseye-slim

RUN adduser --disabled-password --gecos "" --no-create-home --uid 1000 cronos

RUN mkdir -p /home/cronos/data && mkdir -p /home/cronos/config
RUN apt-get update -y && apt-get install wget curl procps net-tools jq lz4 -y
RUN cd /tmp && wget --no-check-certificate https://github.com/crypto-org-chain/cronos/releases/tag/v0.6.0-testnet/cronos_0.6.0-testnet_Linux_x86_64.tar.gz \
    && tar -xvf cronos_0.6.0-testnet_Linux_x86_64.tar.gz \
    && rm cronos_0.6.0-testnet_Linux_x86_64.tar.gz && mv ./* /home/cronos/

RUN chown -R cronos:cronos /home/cronos

USER root

ENTRYPOINT ["/home/cronos/bin/cronosd"]
