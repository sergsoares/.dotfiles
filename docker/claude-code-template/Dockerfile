FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Base utilities and build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    unzip \
    git \
    less \
    vim \
    nano \
    build-essential \
    pkg-config \
    gnupg \
    wget \
    jq \
    apt-transport-https \
    software-properties-common \
 && rm -rf /var/lib/apt/lists/*

# Install .NET 8 SDK (official Microsoft packages)
RUN set -eux; \
    apt-get update; \
    wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb; \
    dpkg -i /tmp/packages-microsoft-prod.deb; \
    rm /tmp/packages-microsoft-prod.deb; \
    apt-get update; \
    apt-get install -y --no-install-recommends dotnet-sdk-8.0; \
    rm -rf /var/lib/apt/lists/*

# Install Go (Ubuntu package)
RUN apt-get update && apt-get install -y --no-install-recommends \
    golang-go \
 && rm -rf /var/lib/apt/lists/*

# Install kubectl with checksum verification (multi-arch)
ARG KUBECTL_VERSION=v1.30.0
RUN set -eux; \
    arch="$(dpkg --print-architecture)"; \
    case "$arch" in \
        amd64) kubectl_arch=amd64 ;; \
        arm64) kubectl_arch=arm64 ;; \
        *) echo "Unsupported architecture for kubectl: $arch"; exit 1 ;; \
    esac; \
    curl -fsSLo /tmp/kubectl "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${kubectl_arch}/kubectl"; \
    curl -fsSLo /tmp/kubectl.sha256 "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${kubectl_arch}/kubectl.sha256"; \
    echo "$(cat /tmp/kubectl.sha256)  /tmp/kubectl" | sha256sum --check -; \
    install -m 0755 /tmp/kubectl /usr/local/bin/kubectl; \
    rm -f /tmp/kubectl /tmp/kubectl.sha256

# Install AWS CLI v2 (multi-arch)
RUN set -eux; \
    arch="$(dpkg --print-architecture)"; \
    case "$arch" in \
        amd64) aws_arch=x86_64 ;; \
        arm64) aws_arch=aarch64 ;; \
        *) echo "Unsupported architecture for AWS CLI: $arch"; exit 1 ;; \
    esac; \
    curl -fsSLo /tmp/awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-${aws_arch}.zip"; \
    unzip -q /tmp/awscliv2.zip -d /tmp; \
    /tmp/aws/install; \
    rm -rf /tmp/aws /tmp/awscliv2.zip

# Copy entrypoint and set permissions as root
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Create non-root user and workspace
RUN useradd -ms /bin/bash claude && \
    mkdir -p /workspace && \
    chown -R claude:claude /workspace /home/claude

USER claude
WORKDIR /workspace
ENV HOME=/home/claude
ENV PATH="${HOME}/.local/bin:${PATH}"

# Install Claude Code CLI as claude user so it's on PATH
RUN set -eux; \
    curl -fsSL https://claude.ai/install.sh | bash

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]

