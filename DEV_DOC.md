# Developer Documentation

## Project Overview

Inception is a Docker-based infrastructure project that demonstrates containerization best practices. It runs WordPress with NGINX and MariaDB, each in its own container, built from custom Dockerfiles without pulling pre-built images from Docker Hub.

## Environment Setup

### Prerequisites
- Linux system with Docker and Docker Compose installed
- `make` utility
- Text editor for configuration
- Git (optional, for version control)

### Initial Configuration

#### 1. Clone or Navigate to Project
```bash
cd /path/to/inception
```

#### 2. Configure Environment Variables
The `.env` file is automatically created from `.env.example` on first run. To customize before building:

1. Check `.env.example` for available variables
2. Modify `.env` as needed (optional—defaults work for most cases)
3. Key variables to consider:
   - `DOMAIN_NAME`: Domain for the site (default: login.42.fr, replace "login" with your own)
   - `WP_ADMIN_USER`, `WP_ADMIN_PASS`: WordPress admin credentials
   - `DB_USER`, `DB_PASS`: Database credentials

#### 3. Update /etc/hosts
```bash
sudo vi /etc/hosts
```
Add this line (replace login.42.fr with your DOMAIN_NAME):
```
127.0.0.1    login.42.fr
```

## Building and Launching

### Makefile Commands

#### Build Images and Create Directories
```bash
make
```
- Creates necessary data directories
- Generates `.env` file from `.env.example` (if it doesn't exist)
- Builds all three Docker images from custom Dockerfiles

#### Start Containers
```bash
make up
```
- Starts all three services
- Creates and connects to Docker network
- Mounts volumes for data persistence
- Can be run multiple times without conflicts

#### Stop Containers
```bash
make down
```
- Stops all running containers
- Preserves all data (volumes remain intact)
- Can restart later with `make up`

#### View Running Containers
```bash
make ps
```
- Lists container status
- Shows which services are running

#### Clean Everything
```bash
make clean
```
- Stops containers
- Removes all images
- Removes all volumes and persisted data
- **Warning:** This deletes all website content and database data

## Docker Compose Management

### Manual Container Operations

#### Build Specific Service
```bash
docker compose build <service_name>
# Example: docker compose build wordpress
```

#### Start/Stop Specific Service
```bash
docker compose up -d <service_name>
docker compose down <service_name>
# Example: docker compose up -d mariadb
```

#### Access Container Shell
```bash
docker exec -it <container_name> bash
# Example: docker exec -it wordpress bash
```

#### View Real-time Logs
```bash
docker compose logs -f <service_name>
# Example: docker compose logs -f nginx
```

## Volume and Data Management

### Data Storage Structure

#### WordPress Files
- **Location:** Data persists in a Docker volume (`website_data`)
- **Contains:** WordPress installation, themes, plugins, uploads
- **Host Backup:** Not directly accessible on host (stored by Docker)

#### MariaDB Data
- **Location:** Data persists in a Docker volume (`database_data`)
- **Contains:** WordPress database, tables, and all content
- **Host Backup:** Not directly accessible on host (stored by Docker)

#### TLS Certificates
- **Location:** Custom-built certificates stored with NGINX
- **Contains:** Self-signed SSL certificates for HTTPS
- **Path in Container:** `/etc/nginx/ssl/`

### Viewing Volumes

#### List All Volumes
```bash
docker volume ls
```

#### Inspect Volume Location
```bash
docker volume inspect <volume_name>
# Example: docker volume inspect inception_db_data
```

#### Backup Database
```bash
docker exec inception_mariadb mysqldump -u<DB_USER> -p<DB_PASSWORD> <DB_NAME> > backup.sql
```

#### Restore Database
```bash
docker exec -i inception_mariadb mysql -u<DB_USER> -p<DB_PASSWORD> <DB_NAME> < backup.sql
```

## Project Structure

```
inception/
├── Makefile					# Build and launch commands
├── README.md					# Build and launch commands
├── DEV_DOC.md					# Build and launch commands
├── USER_DOC.md					# Build and launch commands
├── srcs/
|   ├── .env.example			# Template for .env
│   ├── docker compose.yml		# Docker Compose configuration
│   └── requirements/
│       ├── nginx/				# NGINX service
│       │   ├── Dockerfile		# Custom NGINX image
│       │   ├── conf/			# nginx.conf configuration
│       │   └── tools/			# Setup scripts
│       ├── wordpress/			# WordPress service
│       │   ├── Dockerfile		# Custom WordPress image
│       │   ├── conf/			# www.conf (PHP-FPM config)
│       │   └── tools/			# Installation scripts
│       └── mariadb/			# MariaDB service
│           ├── Dockerfile		# Custom MariaDB image
│           ├── conf/			# server.cnf configuration
│           └── tools/			# Database initialization scripts
└── documentation files			# README, USER_DOC, DEV_DOC
```

## Common Development Tasks

### Rebuilding After Dockerfile Changes
```bash
docker compose down
make clean
make
make up
```

### Testing Service Connectivity
```bash
# From WordPress container, ping MariaDB
docker exec inception_wordpress ping mariadb

# From NGINX container, test WordPress connectivity
docker exec inception_nginx curl http://wordpress:9000/
```

### Checking Service Logs
```bash
# All services
docker compose logs

# Specific service (follow mode)
docker compose logs -f mariadb
```

### Accessing Database Directly
```bash
docker exec -it inception_mariadb mysql -u <DB_USER> -p<DB_PASSWORD> <DB_NAME>
```

### Modifying WordPress Configuration
```bash
docker exec -it inception_wordpress bash
# Inside container, edit /var/www/wordpress/wp-config.php or similar
```

## Debugging

### Service Won't Start
1. Check logs: `docker compose logs <service>`
2. Verify Dockerfile syntax in `srcs/requirements/<service>/`
3. Ensure ports are not already in use
4. Check disk space: `df -h`

### Database Connection Issues
1. Verify `docker compose.yml` environment variables match `.env`
2. Check MariaDB is running: `docker compose ps`
3. Test connection: `docker exec inception_wordpress mysql -h mariadb -u <USER> -p<PASSWORD>`

### NGINX/WordPress Connection Issues
1. Check NGINX logs: `docker compose logs nginx`
2. Verify WordPress container is running: `docker compose ps`
3. Test from NGINX container: `docker exec inception_nginx curl http://wordpress:9000/`

### Permission Errors
1. Docker volumes require proper permissions
2. Use `docker exec` with correct user context
3. Check Dockerfile USER directives

## Performance and Optimization

### Reduce Build Time
- Cached layers are preserved between builds
- Avoid changing base image layers
- Order Dockerfile commands by frequency of change

### Monitor Resource Usage
```bash
docker stats
```

### Cleanup Unused Resources
```bash
docker system prune  # Remove unused images, containers, networks
```

## Deployment Notes

This setup is for development/learning purposes. For production, you should:
- Use strong, randomly generated passwords
- Use proper SSL certificates (not self-signed)
- Configure backup strategies for database volumes
- Implement proper logging and monitoring
- Use secrets management instead of `.env` files
- Run containers with non-root users (already configured)
- Implement health checks and restart policies

## Resources

- [Docker Documentation](https://docs.docker.com)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [MariaDB Documentation](https://mariadb.com/docs/)
- [WordPress Developer Handbook](https://developer.wordpress.org/)
