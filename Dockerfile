FROM ubuntu:latest

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y \
  unbound \
  dnsutils \
  wget

# Get the latest list of root servers
RUN wget https://www.internic.net/domain/named.root -qO- > /var/lib/unbound/root.hints \
  && chown -R unbound /var/lib/unbound/root.hints

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