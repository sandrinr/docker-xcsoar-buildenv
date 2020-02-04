FROM debian:stretch

RUN set -x && \
  apt-get update && \
  apt-get install --yes --no-install-recommends \
    automake \
    bzip2 \
    fakeroot \
    ffmpeg \
    fonts-dejavu \
    g++ \
    gettext \
    imagemagick \
    libasound2-dev \
    libcurl4-openssl-dev \
    libegl1-mesa-dev \
    libfreetype6-dev \
    libgeotiff-dev \
    libgl1-mesa-dev \
    libinput-dev \
    libjpeg-dev \
    liblua5.2-dev \
    libpng-dev \
    librsvg2-bin \
    librsvg2-bin \
    libsdl2-dev \
    libtiff5-dev \
    libxml-parser-perl \
    lua5.2-dev \
    m4 \
    make \
    mesa-common-dev \
    pkg-config \
    quilt \
    ttf-bitstream-vera \
    xsltproc \
    zip \
    zlib1g-dev \
    && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

ENV DISPLAY=host.docker.internal:0
