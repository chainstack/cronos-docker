FROM debian:bullseye-slim

RUN adduser --disabled-password --gecos "" --no-create-home --uid 1000 cronos

RUN mkdir -p /home/cronos/data && mkdir -p /home/cronos/config
RUN apt-get update -y && apt-get install wget curl procps net-tools jq lz4 -y
RUN cd /home/cronos && wget --no-check-certificate https://github.com/crypto-org-chain/cronos/releases/download/v1.0.2/cronos_1.0.2-testnet_Linux_x86_64.tar.gz && tar -xvf cronos_1.0.2-testnet_Linux_x86_64.tar.gz \
    && rm cronos_1.0.2-testnet_Linux_x86_64.tar.gz
RUN chown -R cronos:cronos /home/cronos

USER cronos

ENTRYPOINT ["/home/cronos/bin/cronosd"]
