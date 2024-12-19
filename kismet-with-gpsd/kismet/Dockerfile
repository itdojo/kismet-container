#
# For Gateworks, Raspbery Pi and other similar SBCs, create
# a swapfile (~8GB) before building this image to avoid
# running out of memory during the build process.
#
# First stage: Build Stage
FROM ubuntu:22.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    libbtbb-dev \
    libcap-dev \
    libdw-dev \
    libmosquitto-dev \
    libnl-3-dev \
    libnl-genl-3-dev \
    libnm-dev \
    libpcap-dev \
    libpcre3-dev \
    libprotobuf-c-dev \
    libprotobuf-dev \
    librtlsdr0 \
    libsensors4-dev \
    libsqlite3-dev \
    libubertooth-dev \
    libusb-1.0-0-dev \
    libwebsockets-dev \
    make \
    pkg-config \
    protobuf-c-compiler \
    protobuf-compiler \
    python3 \
    python3-dev \
    python3-numpy \
    python3-protobuf \
    python3-requests \
    python3-serial \
    python3-setuptools \
    python3-usb \
    python3-websockets \
    rtl-433 \
    rtl-sdr \
    tzdata \
    zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

# Clone, build, and install librtlsdr from source
RUN git clone https://github.com/osmocom/rtl-sdr.git /tmp/rtl-sdr && \
    cd /tmp/rtl-sdr && \
    mkdir build && cd build && \
    cmake .. && \
    make && \
    make install && \
    ldconfig && \
    cd / && \
    rm -rf /tmp/rtl-sdr

# Clone, build, and install Kismet from source
RUN git clone https://www.kismetwireless.net/git/kismet.git /tmp/kismet && \
    cd /tmp/kismet && \
    ./configure --enable-pcre && \
    make -j$(nproc) && \
    echo "kismet-core   kismet-common/install-setuid    boolean true" | debconf-set-selections && \
    make suidinstall && \
    cd / && \
    rm -rf /tmp/kismet

# Second stage: Final runtime image
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV KISMET_LOG_DIR=/kismet_logs
ENV KISMET_CONF_DIR=/usr/local/etc/

# Install only runtime dependencies, excluding rtl-sdr (built from source in the builder stage)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    librtlsdr0 \
    libcap2-bin \
    libmosquitto1 \
    libnl-3-200 \
    libnl-genl-3-200 \
    libnm0 \
    libpcap0.8 \
    libpcre3 \
    libpcre3-dev \
    libprotobuf-c1 \ 
    libsensors* \
    libsqlite3-0 \
    libubertooth1 \
    libusb-1.0-0 \
    libwebsockets* \
    libdw1 \
    python3 \
    python3-numpy \
    python3-protobuf \
    python3-requests \
    python3-serial \
    python3-usb \
    python3-websockets \
    tzdata \
    wireless-tools \
    zlib1g && \
    rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime

# Copy the Kismet installation and rtl-sdr tools from the builder stage
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/local/include /usr/local/include
COPY --from=builder /usr/local/etc /usr/local/etc
COPY --from=builder /usr/local/share/kismet /usr/local/share/kismet

# Create necessary directories for logs and config files
# Run ldconfig to link libraries
# Remove unneeded packages and files to reduce image size
RUN mkdir -p $KISMET_LOG_DIR KISMET_CONF_DIR && \
    ldconfig && \
    apt-get purge -y --auto-remove && \
    rm -rf /usr/share/doc /usr/share/man /usr/share/locale /tmp/* /var/tmp/*

EXPOSE 2501

# Set CMD to run Kismet
CMD ["kismet"]
