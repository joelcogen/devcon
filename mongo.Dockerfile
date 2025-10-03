FROM debian:bookworm-slim

RUN apt update -qq && apt install -y curl

RUN curl -O http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.1w-0+deb11u3_arm64.deb && \
    apt install -y ./libssl*.deb && \
    rm libssl*.deb

RUN curl -O https://repo.mongodb.org/apt/ubuntu/dists/focal/mongodb-org/8.0/multiverse/binary-arm64/mongodb-org-server_8.0.3_arm64.deb && \
    apt install -y ./mongodb-org-server_8.0.3_arm64.deb && \
    rm mongodb-org-server_8.0.3_arm64.deb

RUN mkdir -p /data/db

EXPOSE 27017
CMD ["mongod", "--bind_ip_all"]
