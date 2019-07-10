FROM python:3

RUN apt update                     && \
    apt install -q -y curl         && \
    apt install -q -y jq           && \
    rm -rf /var/lib/apt/lists

COPY build-catalog.sh /usr/local/bin/


ENTRYPOINT ["/usr/local/bin/build-catalog.sh"]