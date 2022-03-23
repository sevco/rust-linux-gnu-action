ARG TOOLCHAIN
FROM centos:8

ENV RUSTUP_HOME=/opt/rust/rustup \
    CARGO_HOME=/opt/rust/cargo \
    PATH=/opt/rust/cargo/bin:$PATH 

RUN set -eux; \
    yum -y update && \
    yum -y install \
       ca-certificates \
       curl \
       gcc \
       glibc-devel \
       git \
       rpm-build; \
    curl https://static.rust-lang.org/rustup/archive/1.22.1/x86_64-unknown-linux-gnu/rustup-init -o rustup-init; \
    ls -al; \
    echo '49c96f3f74be82f4752b8bffcf81961dea5e6e94ce1ccba94435f12e871c3bdb *rustup-init' | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $TOOLCHAIN --default-host x86_64-unknown-linux-gnu; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version; \
    yum clean all && \
    rm -rf /var/cache/yum && \
    printf '[net] \ngit-fetch-with-cli = true\n' >> /opt/rust/cargo/config

RUN env CARGO_HOME=/opt/rust/cargo cargo install --git https://github.com/sevincit/cargo-rpm --branch=develop cargo-rpm && \
    env CARGO_HOME=/opt/rust/cargo cargo install -f cargo-deb && \
    rm -rf /opt/rust/cargo/registry/

USER root

RUN mkdir -p /github
RUN useradd -m -d /github/home -u 1001 github

ADD entrypoint.sh cleanup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/cleanup.sh

USER github
WORKDIR /github/home

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
