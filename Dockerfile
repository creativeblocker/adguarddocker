FROM alpine:latest

# Install required packages
RUN apk add --no-cache ca-certificates wget

# Create configuration directory
RUN mkdir -p /etc/adguardhome

# Copy AdGuard Home configuration
COPY adguardhome.conf /etc/adguardhome/

# Download AdGuard Home binary (replace with correct version and architecture)
ARG ADGUARDHOME_VERSION=v0.108.2
ARG ADGUARDHOME_ARCH='x86'  # Enclose the value in single quotes

RUN wget https://github.com/AdGuardTeam/AdGuardHome/releases/download/$ADGUARDHOME_VERSION/AdGuardHome_linux_$ADGUARDHOME_ARCH -O /usr/local/bin/adguardhome \
    && chmod +x /usr/local/bin/adguardhome

# Expose port 53 for DNS
EXPOSE 53

# Command to run AdGuard Home
CMD ["/usr/local/bin/adguardhome", "-config", "/etc/adguardhome/AdGuardHome.conf"]
