FROM node:24.22.1-bookworm
MAINTAINER "Manojvv" "manojv@ilimi.in"
USER root
COPY src /opt/content/
WORKDIR /opt/content/
RUN npm install --unsafe-perm

FROM node:24.22.1-bookworm-slim
MAINTAINER "Manojvv" "manojv@ilimi.in"
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssl imagemagick \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m sunbird
USER sunbird

COPY --from=0 --chown=sunbird /opt/content /home/sunbird/mw/content
WORKDIR /home/sunbird/mw/content/
CMD ["node", "app.js", "&"]
