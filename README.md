# A Caddy based Reverse Proxy for NodeJS apps

This is a reverse proxy for different NodeJS / ExpressJS applications running inside one shared server (typically AWS Lightsail).

The assumption is that each application has a corresponding domain (or subdomain), which points at a `LoadBalancer` routing to the server (e.g. Lightsail).

PLEASE NOTE

The secure https connection ends at the LoadBalancer level. Then Caddy takes over and the entire routing inside the Lightsail and (including Docker network) happens over http.

# Shared network

Because all services are orchestrated separately by their own respective `docker-compose.yml` files, Caddy needs a way to connect them in one shared network. Ensure to create such network by running i.e. `docker network create lbt-net` at least once in any environment where this is being set up.

Then ensure that each services are attached to that network:

```
networks:
  lbt-net:
    external: true
    name: lbt-network
```

# How to run it?

Go to each respective service and run `./scripts/deploy.sh`. It will pull the latest from the `master` branch and run the `docker compose up -d --build` command under the hood.
