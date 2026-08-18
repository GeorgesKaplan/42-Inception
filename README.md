*This project has been created as part of the 42 curriculum by dnantet.*

# Inception

## Description

Inception is a sysadmin project that builds a small web infrastructure from scratch using Docker. The goal is to run a WordPress website behind an NGINX reverse proxy with TLS, backed by a MariaDB database, where every service lives in its own container built from a hand-written Dockerfile (no pull from DockerHub).

## Instructions

### Requirements

- A Linux virtual machine with Docker
- Redirecting **localhost** in `/etc/hosts`:

```
127.0.0.1    localhost
=>
127.0.0.1    dnantet.42.fr
```

### Build and run

```bash
make        # create data directories and build images
make up     # start containers
make down   # stop containers
make ps     # lists containers
make clean  # remove containers, images, volumes and data
```

A `.env` file is automatically created and populated when `make` is first ran. If you wish to change its content beforehand, you have to modify the `.env.example` template.

### Access

The website can be accessed at https://dnantet.42.fr. \
To access as admin, go to https://dnantet.42.fr/wp-admin.

The TLS certificate is self-signed, so browsers will display a warning on first visit.

## Project description

### Virtual Machine VS Docker

Docker provides lightweight containerisation compared to virtual machines. Instead of running a full OS for each service, Docker containers share the host kernel while isolating processes, dependencies, and filesystems. This makes them faster to start, more resource-efficient, and easier to manage than running NGINX, MariaDB, and WordPress on separate VMs.\
This also solves the eternal issue of "It works on my machine".

### Secrets VS Environment Variables

Environment variables are suitable for non-sensitive configuration like database names and domains. Secrets should be stored securely in files (mounted as secrets in production) for sensitive data like passwords and API keys.

### Docker Network vs Host Network

This project uses a Docker bridge network to connect containers: NGINX, WordPress, and MariaDB communicate through their container names. The host network exposes services directly on the host OS, bypassing network isolation. Bridge networks are preferred here because they provide better security and isolation while still allowing inter-container communication.

### Docker Volumes vs Bind Mounts

Volumes are Docker-managed storage isolated from the host, ideal for data that should persist independently (database data, WordPress files). Bind mounts link directories directly between host and container, useful for development but less portable. This project uses volumes for MariaDB data and WordPress files to ensure data persistence and portability across systems.

## Resources

### Documentation

- Other students who already completed the project
- [Official Docker documentation](https://docs.docker.com)
- A lot of Youtube tutorials, but mainly these three:
    - [Get Started](https://www.youtube.com/watch?v=DQdB7wFEygo)
    - [Intro to Docker](https://www.youtube.com/watch?v=Ud7Npgi6x8E)
    - [Docker Compose](https://www.youtube.com/watch?v=HGKfE-cn9y4)

### AI usage
For debugging. A lot of debugging. 🥲
