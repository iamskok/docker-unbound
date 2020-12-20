To fix `so-rcvbuf 1048576 was not granted` warning run container in `priviledged` mode.

```
docker run --privileged iamskok/unbound
```

- Unbound is throwing error when the image is pulled from registry (runs locally)
  - docker inspect / logs to find out the reason
- Fix `so-rcvbuf 1048576 was not granted` warning
  - https://www.reddit.com/r/pihole/comments/avtocx/unbound_problem/ehi3orv/
  - https://wiki.alpinelinux.org/wiki/Sysctl.conf
  - https://askubuntu.com/questions/1285370/trying-to-allocate-more-ram-to-unbound-and-getting-a-warning-to-fix-start-with
- Possibly will have this issue https://stackoverflow.com/questions/54066522/pihole-and-unbound-in-docker-containers-unbound-not-receiving-requests
- Use port 53 instead of 5335?
- Change verbosity level
- Set RAM and CPU cores for each container
- 0.0.0.0 vs 127.0.0.0
- Test perf https://github.com/jedisct1/dnsblast

```
dig sigfail.verteiltesysteme.net @0.0.0.0 -p 53
dig sigok.verteiltesysteme.net @0.0.0.0 -p 53

dig sigfail.verteiltesysteme.net @127.0.0.1 -p 5335
dig sigok.verteiltesysteme.net @127.0.0.1 -p 5335

drill -p 53 sigfail.verteiltesysteme.net @127.0.0.1
drill -p 53 sigok.verteiltesysteme.net @127.0.0.1
```

- Test perf `time dig bloomberg.com`
- [Example of good unbound log](https://www.reddit.com/r/pihole/comments/ah0rx4/awesome_unbound_docker_image_for_an_upstream_dns/eeakmdp?utm_source=share&utm_medium=web2x&context=3)

Links
- https://www.reddit.com/r/pihole/comments/d9j1z6/unbound_as_recursive_dns_server_slow_performance/
- https://gitlab.com/klutchell/unbound
- DNSSEC algorithm check https://www.rootcanary.org/test.html
- DNS types https://www.cloudflare.com/learning/dns/dns-server-types/
- Unbound config example https://github.com/MatthewVance/unbound-docker/issues/21#issuecomment-508919167