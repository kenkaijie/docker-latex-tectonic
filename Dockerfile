FROM rust:stretch as builder
RUN apt-get update && apt-get -y install libfontconfig1-dev libgraphite2-dev libharfbuzz-dev libicu-dev libssl-dev zlib1g-dev
RUN cargo install tectonic

# use tectonic here to install the base extras needed by the system, used to cache the packages for later use
# cant be done in the slim version as the SSL is not installed on the docker image
WORKDIR /usr/src
COPY *.tex ./
COPY *.in ./
RUN for f in *.tex; do tectonic $f; done

FROM debian:stretch-slim
RUN apt-get update && apt-get -y install libfontconfig1 libharfbuzz-icu0 ca-certificates
COPY --from=builder /usr/local/cargo/bin/tectonic /usr/bin/
COPY --from=builder /root/.cache/Tectonic/ /root/.cache/Tectonic/
WORKDIR /usr/src