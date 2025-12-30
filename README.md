# A Caddy based Reverse Proxy for NodeJS apps

This is a reverse proxy for different NodeJS / ExpressJS applications running inside one shared server (typically AWS Lightsail).

The assumption is that each application has a corresponding domain (or subdomain), which points at a `LoadBalancer` routing to the server (e.g. Lightsail).

PLEASE NOTE

The secure https connection ends at the LoadBalancer level. Then Caddy takes over and the entire routing inside the Lightsail and (including Docker network) happens over http.

# Reverse proxy

Caddy maps the incoming requests from subdomains to internal apps running in containers. The names of these apps are defined in their respective docker-compose.yml files, e.g.

```
@auth host auth.libtomsoftware.com auth.localhost
	handle @auth {
		reverse_proxy lbt-auth-api:3000
	}
```

or

```
@gateway host gateway.libtomsoftware.com gateway.localhost
	handle @gateway {
		reverse_proxy lbt-gateway:4000
	}
```

PLEASE NOTE

To connect on the remote server via `auth.libtomsoftware.com` or `gateway.libtomsoftware.com` use https.
To connect on the localhost via `auth.localhost` or `gateway.localhost` use http.

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

To run each deplpyment manually, go to each respective service and run `./scripts/deploy.sh`. It will pull the latest from the `master` branch and run the `docker compose up -d --build` command under the hood.

To update and restart all of them, run the `/scripts/deploy-all.sh` script from this repo.
