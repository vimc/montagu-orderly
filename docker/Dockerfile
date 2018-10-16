FROM docker.montagu.dide.ic.ac.uk:5000/orderly.server:1627464

# install npm
RUN apt-get update && \
  apt-get -y install curl gnupg && \
  curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get -y install nodejs npm

# Install LaTeX
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ghostscript \
    imagemagick \
    lmodern \
    texlive-fonts-recommended \
    texlive-humanities \
    texlive-latex-extra \
    texinfo \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/ \
  && cd /usr/share/texlive/texmf-dist \
  && wget http://mirrors.ctan.org/install/fonts/inconsolata.tds.zip \
  && unzip inconsolata.tds.zip \
  && rm inconsolata.tds.zip \
  && echo "Map zi4.map" >> /usr/share/texlive/texmf-dist/web2c/updmap.cfg \
  && mktexlsr \
  && updmap-sys

# Install Pandoc
ENV PANDOC_VERSION "1.19.2.1"
RUN wget https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb \
  && dpkg --install pandoc-${PANDOC_VERSION}-1-amd64.deb \
  && rm pandoc-${PANDOC_VERSION}-1-amd64.deb

# system dependencies required to install and run R packages (in
# alphabetical order)
RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libmagick++-dev \
  libxml2-dev

# Add new packages here (in alphabetical order)
RUN install2.r --error \
  RColorBrewer \
  RcppRoll \
  captioner \
  car \
  dplyr \
  drat \
  ggplot2 \
  ggpubr \
  gridExtra \
  janitor \
  kableExtra \
  knitr \
  magick \
  markdown \
  officer \
  pander \
  readxl \
  spelling \
  tidyr

ARG GIT_ID='UNKNOWN'
ARG GIT_BRANCH='UNKNOWN'
ENV ORDERLY_MONTAGU_GIT_HASH $GIT_ID
ENV ORDERLY_MONTAGU_GIT_BRANCH $GIT_BRANCH
ENV TZ=Europe/London

COPY docker/orderly_config.yml /etc/montagu/orderly_config.yml
COPY docker/orderly_init /usr/bin/orderly_init

WORKDIR /orderly
