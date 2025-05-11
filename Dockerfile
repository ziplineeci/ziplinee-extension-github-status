# Stage 1: Install certs and prepare binary
FROM alpine:3.18 AS base
RUN apk add --no-cache ca-certificates
COPY publish/ziplinee-extension-github-status /ziplinee-extension-github-status

# Stage 2: Build secure scratch image
FROM scratch

LABEL maintainer="helm-ziplineeci.malsharbaji.com." \
    description="The ziplinee-extension-github-status component is an ZiplineeCI extension to update build status in Github for builds handled by ZiplineeCI"

# Copy certs to default trust location
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

# Copy binary
COPY --from=base //ziplinee-extension-github-status //ziplinee-extension-github-status

# Env vars
ENV ESTAFETTE_LOG_FORMAT="console"


ENTRYPOINT ["/ziplinee-extension-github-status"]




