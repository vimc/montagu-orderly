FROM docker.montagu.dide.ic.ac.uk:5000/orderly:9008e65

RUN apt-get update && apt-get install -y git

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
#
# https://hub.docker.com/r/cardcorp/r-pandoc/~/dockerfile/
RUN mkdir -p /opt/pandoc \
  && wget --no-check-certificate -O /tmp/pandoc.zip https://s3.amazonaws.com/rstudio-buildtools/pandoc-1.13.1.zip \
  && unzip -j /tmp/pandoc.zip "pandoc-1.13.1/linux/debian/x86_64/pandoc" -d /opt/pandoc \
  && chmod +x /opt/pandoc/pandoc \
  && ln -s /opt/pandoc/pandoc /usr/local/bin \
  && unzip -j /tmp/pandoc.zip "pandoc-1.13.1/linux/debian/x86_64/pandoc-citeproc" -d /opt/pandoc \
  && chmod +x "/opt/pandoc/pandoc-citeproc" \
  && ln -s "/opt/pandoc/pandoc-citeproc" /usr/local/bin \
  && rm -f /tmp/pandoc.zip

# dependencies for R packages
RUN apt-get update && apt-get install -y \
  libcurl4-openssl-dev \
  libxml2-dev

RUN install2.r --error \
  RColorBrewer \
  RcppRoll \
  ggplot2 \
  gridExtra \
  kableExtra \
  knitr \
  markdown

ARG GIT_ID='UNKNOWN'
ARG GIT_BRANCH='UNKNOWN'
ENV ORDERLY_MONTAGU_GIT_HASH $GIT_ID
ENV ORDERLY_MONTAGU_GIT_BRANCH $GIT_BRANCH

COPY orderly_config.yml /etc/montagu/orderly_config.yml
COPY docker/orderly_init /usr/bin/orderly_init
COPY docker/montagu-reports-clone /usr/bin/montagu-reports-clone
COPY docker/montagu-reports-pull /usr/bin/montagu-reports-pull
COPY docker/montagu-reports-init /usr/bin/montagu-reports-init
