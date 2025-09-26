FROM debian:bullseye-slim

# Create user & directories
RUN adduser --disabled-password --gecos "" --no-create-home --uid 1000 cronos \
    && mkdir -p /home/cronos/data /home/cronos/config /home/cronos/bin

# Install dependencies
RUN apt-get update -y && apt-get install -y wget curl procps net-tools jq lz4

WORKDIR /tmp

# Download and verify tarball
RUN wget https://github.com/crypto-org-chain/cronos/releases/download/v1.5.0/cronos_1.5.0-testnet_Linux_x86_64.tar.gz \
    && echo "d917ca990ed2415905a44ec48d6047664dad06b3441cd09b116f86f1880b1c2b  cronos_1.5.0-testnet_Linux_x86_64.tar.gz" | sha256sum -c -

# Extract and move binary
RUN tar -xzf cronos_1.5.0-testnet_Linux_x86_64.tar.gz \
    && mv bin/cronosd /home/cronos/bin/cronosd \
    && rm -rf cronos_1.5.0-testnet_Linux_x86_64 cronos_1.5.0-testnet_Linux_x86_64.tar.gz

# Validate binary hash
RUN sha256sum /home/cronos/bin/cronosd

# Set permissions
RUN chown -R cronos:cronos /home/cronos && chmod 1777 /tmp

USER cronos
WORKDIR /home/cronos

ENTRYPOINT ["/home/cronos/bin/cronosd"]
