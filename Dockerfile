FROM alpine:latest AS builder

LABEL \
    org.opencontainers.image.title="Nebula Lighthouse - Builder" \
    org.opencontainers.image.authors="Satish P K" \
    org.opencontainers.image.source="https://github.com/satishpkb/nebula-lighthouse"

ARG NEBULA_VERSION="1.5.0"
ARG NEBULA_CHECKSUM="c70929951f11c697f0f17b4175e672d93f64c88114a66c4dd05cc23e6390a3d9"
ARG NEBULA_URL="https://github.com/slackhq/nebula/releases/download/v${NEBULA_VERSION}/nebula-linux-amd64.tar.gz"

RUN apk update \
    && apk add --no-cache tar ca-certificates wget \
    && update-ca-certificates \
    && wget -O nebula.tar.gz ${NEBULA_URL} \
    && echo "${NEBULA_CHECKSUM}  nebula.tar.gz" | sha256sum -c \
    && tar -xzvf nebula.tar.gz -C /usr/local/bin/ \
    && rm -rf nebula.tar.gz


FROM alpine:latest

LABEL \
    org.opencontainers.image.title="Nebula Lighthouse" \
    org.opencontainers.image.description="Dockerized Nebula Lighthouse. Nebula is a scalable overlay networking tool with a focus on performance, simplicity and security from Slack" \
    org.opencontainers.image.authors="Satish P K" \
    org.opencontainers.image.vendor="Codefiniti Technologies" \
    org.opencontainers.image.version="${NEBULA_VERSION}" \
    org.opencontainers.image.source="https://github.com/satishpkb/nebula-lighthouse" \
    org.opencontainers.image.url="https://github.com/satishpkb/nebula-lighthouse" \
    org.opencontainers.image.documentation="https://github.com/satishpkb/nebula-lighthouse" \
    org.opencontainers.image.licenses="MIT"

COPY --from=builder /usr/local/bin/nebula /usr/local/bin/nebula
COPY config-lighthouse.yaml /config/config.yaml

VOLUME ["/etc/nebula"]

EXPOSE 4242/udp

ENTRYPOINT ["/usr/local/bin/nebula"]
CMD ["-config", "/config/config.yaml"]