FROM debian:bullseye-slim
RUN adduser --disabled-password --gecos "" --no-create-home --uid 1000 cronos
RUN mkdir -p /home/cronos/data && mkdir -p /home/cronos/config
RUN apt-get update -y && apt-get install wget curl procps net-tools jq lz4 git golang make gcc g++ -y
# Build from specific commit
RUN cd /tmp \
    && git clone https://github.com/crypto-org-chain/cronos.git \
    && cd cronos \
    && git checkout <commit-sha> \
    && make build \
    && mv build/cronosd /home/cronos/bin/ \
    && cd / \
    && rm -rf /tmp/cronos
RUN chown -R cronos:cronos /home/cronos && chmod 1777 /tmp
USER root
ENTRYPOINT ["/home/cronos/bin/cronosd"]