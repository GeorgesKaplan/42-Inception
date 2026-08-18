# User Documentation

## Overview

Inception provides a complete WordPress web infrastructure running in Docker containers. The stack includes three services working together to host a WordPress website with security and reliability.

## Services Provided

### NGINX
A reverse proxy and web server that handles incoming HTTPS connections, routes traffic to WordPress, and manages SSL/TLS encryption for secure browsing.

### WordPress
A content management system (CMS) that runs the website. Users can create posts, manage pages, and customize the site through an intuitive admin panel.

### MariaDB
A database server that stores all WordPress data including posts, users, comments, and site settings. It ensures data persists between restarts.

## Starting and Stopping the Project

### Prerequisites
- Ensure your `/etc/hosts` file contains the mapping:
  ```
  127.0.0.1    login.42.fr  #"login" must be your own
  ```
- Linux system with Docker installed

### Start the Project
```bash
make up
```
This builds all containers (if not already built) and starts the services. The first startup may take a minute as WordPress initializes.

### Stop the Project
```bash
make down
```
Stops all running containers while preserving your data.

### Check Project Status
```bash
make ps
```
Lists all running containers and their status.

## Accessing the Website

### Website URL
Open your browser and go to https://login.42.fr

You may see a security warning because the SSL certificate is self-signed. This is normal in development—click "Advanced" and proceed.

### Admin Panel
Access WordPress administration at https://login.42.fr/wp-admin

Log in with your admin credentials to manage the site.

## Credentials

### Admin Access
Credentials are generated automatically in the `.env` file. To find them:

1. Open the `.env` file in the project root
2. Look for these variables:
   - `WP_ADMIN_USER`: WordPress admin username
   - `WP_ADMIN_PASS`: WordPress admin password
   - `WP_ADMIN_EMAIL`: WordPress admin email address

### Database Access
Database credentials are also in `.env`:
- `DB_NAME`: Database name (default: wordpressdb)
- `DB_USER`: Database user
- `DB_PASSWORD`: Database password
- `DB_HOST`: Database host (always: mariadb)

**Important:** Do not share your `.env` file, as it contains sensitive credentials.

## Checking Service Health

### Quick Health Check
```bash
make ps
```
All three services should show as "Up":
- `mariadb` (Database)
- `nginx` (Web Server)
- `wordpress` (CMS)

### Viewing Logs
Check service logs for any issues:
```bash
docker logs <container_name>
```

Example:
```bash
docker logs mariadb
docker logs nginx
docker logs wordpress
```

### Testing Website Functionality
1. Visit https://login.42.fr to confirm the homepage loads.
2. Visit https://login.42.fr/wp-admin and log in to confirm admin access.
3. Try creating a test post and verifying it appears on the homepage.

## Troubleshooting

### Services Won't Start
- Ensure Docker is running with `docker --version`.
- Check available disk space.
- Review logs with `docker logs <container_name>`.

### Can't Access Website
- Verify `/etc/hosts` has the correct entry.
- Ensure containers are running with `make ps`.
- Try waiting 30 seconds for WordPress to fully initialize.
- Clear browser cache and try again.

### Forgot Admin Password
- Access the WordPress database container and reset it.
- Or reinstall by running `make clean` and `make up`.

## Resetting Everything

To start fresh:
```bash
make clean    # Removes containers, images, and data
make          # Rebuilds everything
make up       # Starts services
```

**Warning:** `make clean` permanently deletes all website content and database data.
