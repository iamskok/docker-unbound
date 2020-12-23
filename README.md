# Docker Unbound DNS

Built for the use with Pi-Hole. Compatible with `armv7l` architecture.

## Installation

```sh
docker pull iamskok/unbound
docker run --privileged iamskok/unbound
```

`--privileged` flag is required for extending default kernel buffer size.
For more information check out `so-rcvbuf` comments in `unbound.conf`.

## DNSSEC

DNSSEC can be validated with these commands:

```
drill -p 53 sigfail.verteiltesysteme.net @127.0.0.1
drill -p 53 sigok.verteiltesysteme.net @127.0.0.1
```

---

You might also be interested in [2x Unbound DNS + PiHole](https://github.com/iamskok/docker-unbound-pihole) setup.