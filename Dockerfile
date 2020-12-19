FROM alpine:latest

WORKDIR /var/lib 

RUN apk add --update --no-cache \
  unbound \
  drill \
  wget

# Get the latest list of root servers
RUN mkdir unbound \
  && wget https://www.internic.net/domain/named.root -qO- > unbound/root.hints \
  && chown -R unbound unbound

# Create log file
RUN mkdir /var/log/unbound \
  && touch /var/log/unbound/unbound.log \
  && chown -R unbound /var/log/unbound

# Copy root.key
RUN mkdir /var/unbound \
  && mkdir /var/unbound/etc
COPY root.key /var/unbound/etc
RUN chown unbound /var/unbound/etc

COPY unbound.conf /etc/unbound/unbound.conf

CMD ["unbound", "-d"]
