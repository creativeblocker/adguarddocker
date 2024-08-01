FROM alpine:latest

# Install required packages
RUN apk add --no-cache ca-certificates

# Create configuration directory
RUN mkdir -p /etc/adguardhome

# Copy AdGuard Home configuration
COPY adguardhome.conf /etc/adguardhome/

# Download AdGuard Home binary (replace with correct version)
RUN wget https://github.com/AdGuardTeam/AdGuardHome/releases/download/v0.108.2/AdGuardHome_linux_arm64 -O /usr/local/bin/adguardhome

# Make it executable
RUN chmod +x /usr/local/bin/adguardhome

# Expose port 53 for DNS
EXPOSE 53

# Command to run AdGuard Home
CMD ["/usr/local/bin/adguardhome", "-config", "/etc/adguardhome/AdGuardHome.conf"]
