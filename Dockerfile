FROM alpine:latest

ENV ROOT_HINTS https://www.internic.net/domain/named.root

RUN apk add --update --no-cache \
  unbound \
  wget \
  drill

WORKDIR /etc/unbound

COPY root.key unbound.conf ./

RUN unlink root.hints \
  && wget ${ROOT_HINTS} -qO- | tee root.hints \
  && touch unbound.log \
  && chown -R unbound .

CMD ["unbound", "-d"]
