FROM alpine:latest

# Install required packages
RUN apk add --no-cache ca-certificates wget

# Create configuration directory
RUN mkdir -p /etc/adguardhome

# Copy AdGuard Home configuration
COPY adguardhome.conf /etc/adguardhome/

# Download AdGuard Home binary with retry logic
ARG ADGUARDHOME_VERSION=v0.108.2
ARG ADGUARDHOME_ARCH='i386'  # Assuming x86 architecture

RUN for i in {1..3}; do \
    wget -qO- https://github.com/AdGuardTeam/AdGuardHome/releases/download/$ADGUARDHOME_VERSION/AdGuardHome_linux_$ADGUARDHOME_ARCH \
        && break || echo "Download failed. Retrying..." && sleep 5; \
  done \
  > /usr/local/bin/adguardhome && chmod +x /usr/local/bin/adguardhome

# Expose port 53 for DNS
EXPOSE 53

# Command to run AdGuard Home
CMD ["/usr/local/bin/adguardhome", "-config", "/etc/adguardhome/AdGuardHome.conf"]
