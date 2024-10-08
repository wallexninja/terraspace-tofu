FROM ruby:3.0.3-alpine3.15

RUN apk add ruby-unf_ext cmake build-base git terraform aws-cli

WORKDIR /tmp
ARG PACKAGE_VERSION=latest
COPY bin/install/terraspace/gem.sh bin/install/terraspace/gem.sh

RUN curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
RUN chmod +x install-opentofu.sh
RUN ./install-opentofu.sh --install-method apk

RUN bin/install/terraspace/gem.sh

ENTRYPOINT ["/bin/sh"]