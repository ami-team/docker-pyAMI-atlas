FROM python:3.11-alpine

# Install dépendencies
RUN apk add --no-cache \
    bash \
    tar \
    ca-certificates \
    gcc \
    g++ \
    make \
    musl-dev \
    libffi-dev \
    openssl-dev \
    python3-dev \
    libstdc++ \
    libgcc \
    curl \
    zlib-dev \
    coreutils\
    expect

# Copy local archive
COPY pyAMI-5.1.7.tar.gz /tmp/pyAMI-5.1.7.tar.gz

# Extract pyAMI in /opt
RUN mkdir -p /opt/pyami && \
    tar -xzf /tmp/pyAMI-5.1.7.tar.gz -C /opt/pyami && \
    rm /tmp/pyAMI-5.1.7.tar.gz

# Add pyAMI to PATH and PYTHONPATH
ENV PATH="/opt/pyami/pyAMI-5.1.7/bin:$PATH"
ENV PYTHONPATH="/opt/pyami/pyAMI-5.1.7/lib:$PYTHONPATH"

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

