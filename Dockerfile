# Use Alpine Slim as the base image for a lightweight build
FROM alpine:3.18.4

# Set environment variables
ENV TERRASPACE_VERSION=latest \
  TOFU_VERSION=latest

# Install required dependencies for Terraspace and OpenTofu
RUN apk update && apk add --no-cache \
  bash \
  curl \
  git \
  unzip \
  build-base \
  ruby \
  ruby-dev \
  libc6-compat \
  openssl-dev \
  libffi-dev \
  wget

# Download the installer script:
RUN curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh

# Give it execution permissions:
RUN chmod +x install-opentofu.sh

# Please inspect the downloaded script

# Run the installer:
RUN ./install-opentofu.sh --install-method apk

# Install Bundler and Terraspace
RUN gem install bundler --no-document \
  && gem install terraspace --no-document

# Verify installations
RUN terraspace version && tofu version

# Set the entrypoint for the Docker container
ENTRYPOINT ["/bin/bash"]
