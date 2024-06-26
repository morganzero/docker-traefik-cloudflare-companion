ARG DISTRO="alpine"
ARG DISTRO_VARIANT="3.19"

FROM docker.io/tiredofit/${DISTRO}:${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV CONTAINER_ENABLE_MESSAGING=FALSE \
    CONTAINER_ENABLE_SCHEDULING=FALSE \
    CONTAINER_PROCESS_RUNAWAY_PROTECTOR=FALSE \
    IMAGE_NAME="morganzero/docker-traefik-cloudflare-companion" \
    IMAGE_REPO_URL="https://github.com/morganzero/docker-traefik-cloudflare-companion/"

RUN set -x && \
    addgroup -S -g 8080 tcc && \
    adduser -D -S -s /sbin/nologin \
            -h /dev/null \
            -G tcc \
            -g "tcc" \
            -u 8080 tcc && \
    apk update && \
    apk upgrade && \
    apk add --no-cache \
                cargo \
                gcc \
                libffi-dev \
                musl-dev \
                openssl-dev \
                py3-pip \
                py3-setuptools \
                py3-wheel \
                python3-dev && \
    apk add --no-cache \
                docker-py \
                py3-beautifulsoup4 \
                py3-certifi \
                py3-chardet \
                py3-idna \
                py3-openssl \
                py3-packaging \
                py3-requests \
                py3-soupsieve \
                py3-urllib3 \
                py3-websocket-client \
                py3-yaml \
                python3 && \
    python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install \
            cloudflare==2.19.* \
            get-docker-secret \
            requests && \
    deactivate && \
    apk del \
                cargo \
                gcc \
                libffi-dev \
                musl-dev \
                openssl-dev \
                py3-pip \
                py3-setuptools \
                py3-wheel \
                python3-dev && \
    rm -rf /var/cache/apk/* /root/.cache /root/.cargo

COPY install/ /install/

# Ensure the virtual environment is activated when the container starts
ENV PATH="/opt/venv/bin:$PATH"

CMD ["/bin/sh"]
