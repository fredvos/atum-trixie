# It's just debian:trixie-slim with locales and updates.
# Atum is the Egyptian creator god, the first god in the Heliopolitan ennead.
#

FROM debian:trixie-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq \
    && apt-get --yes upgrade \
    && apt-get --yes install --no-install-recommends apt-utils locales sed \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && locale-gen C.UTF-8 \
    && dpkg-reconfigure locales \
    && /usr/sbin/update-locale LANG=C.UTF-8 \
    && ln -sf /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen \
    && locale-gen

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

COPY bin/get-tags /usr/local/bin/
COPY bin/version-to-tags /usr/local/bin/
RUN chmod +x /usr/local/bin/get-tags /usr/local/bin/version-to-tags
