FROM alpine:latest

RUN \
    # sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --update --no-cache gettext && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /input /output

ADD entrypoint.sh /entrypoint.sh

VOLUME [ "/input" "/output"]

ENTRYPOINT [ "/entrypoint.sh" ]
