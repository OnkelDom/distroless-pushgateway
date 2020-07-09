FROM docker.io/ubuntu:20.04 as builder
ARG version=1.2.0

ADD https://github.com/prometheus/pushgateway/releases/download/v${version}/pushgateway-${version}.linux-amd64.tar.gz /tmp/pushgateway-${version}.linux-amd64.tar.gz
RUN mkdir /app /config /data && \
    tar xvzf /tmp/pushgateway-${version}.linux-amd64.tar.gz -C /tmp/ && \
    mv /tmp/pushgateway-${version}.linux-amd64/pushgateway /app/ && \
    chmod a+x /app/*

# Basic distroless debian10 image
FROM gcr.io/distroless/base-debian10

# Maintaincer label
LABEL maintainer="Dominik Lenhardt <dom@onkeldom.eu>"

# Copy from builder
COPY --chown=nonroot:nonroot --from=builder /app /app
COPY --chown=nonroot:nonroot --from=builder /config /config
COPY --chown=nonroot:nonroot --from=builder /data /data

# Application defaults
WORKDIR /data
VOLUME ["/data"]
EXPOSE 9091

# Application default cmd
CMD ["/app/pushgateway"]
