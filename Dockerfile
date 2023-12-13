FROM debian:bullseye-slim

RUN adduser --disabled-password --gecos "" --no-create-home --uid 1000 cronos

RUN mkdir -p /home/cronos/data && mkdir -p /home/cronos/config
RUN apt-get update -y && apt-get install wget curl procps net-tools jq lz4 -y
RUN cd /tmp && wget --no-check-certificate https://crypto-org-mainnet-fullnode-backup.s3.ap-southeast-1.amazonaws.com/cronos-v1.0.11-hotfix/cronos-v1.0.11-hotfix-x86_64.tar.gz && tar -xvf cronos_1.0.13_Linux_x86_64.tar.gz \
    && rm cronos_1.0.13_Linux_x86_64.tar.gz && mv ./* /home/cronos/
RUN chown -R cronos:cronos /home/cronos

USER cronos

ENTRYPOINT ["/home/cronos/bin/cronosd"]
