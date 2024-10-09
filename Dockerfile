FROM ghcr.io/boltops-tools/terraspace:alpine

RUN apk add curl

RUN curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
RUN chmod +x install-opentofu.sh
RUN ./install-opentofu.sh --install-method apk

ENTRYPOINT ["/bin/sh"]