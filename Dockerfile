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

# Install Tofu
RUN curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
RUN chmod +x install-opentofu.sh
RUN ./install-opentofu.sh --install-method apk

# Install Bundler and Terraspace
RUN gem install bundler --no-document \
  && gem install terraspace --no-document

# Create a symbolic link for terraspace to ensure the Ruby environment is used
RUN ln -s /usr/bin/ruby /usr/local/bin/terraspace-ruby

# Use `terraspace-ruby` to execute terraspace as a Ruby script
RUN echo '#!/usr/bin/env terraspace-ruby' > /usr/local/bin/terraspace \
  && echo 'exec ruby $(which terraspace) "$@"' >> /usr/local/bin/terraspace \
  && chmod +x /usr/local/bin/terraspace

# Verify installations
RUN terraspace version && tofu version

# Set the entrypoint for the Docker container
ENTRYPOINT ["/bin/bash"]
