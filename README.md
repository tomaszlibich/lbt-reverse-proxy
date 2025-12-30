# A Caddy based Reverse Proxy for NodeJS apps

Because all services are orchestrated separately by their own respective docker-compose.yml files, Caddy needs a way to connect them in one shared network. Ensure to create such network by running i.e. `docker network create lbt-net` at least once in any environment where this is being set up.

Then ensure that each services are attached to that network

```
networks:
  lbt-net:
    external: true
    name: lbt-network
```
