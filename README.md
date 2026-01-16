# Laravel Dockerfiles

Optimized Docker images for Laravel applications. Two variants designed for different deployment scenarios.

## Overview

This repository provides production-ready Docker images built on Wolfi Linux for maximum security and minimal footprint.

| Variant | Use Case | Image Size | Idle Memory |
|---------|----------|------------|-------------|
| **PHP-FPM** | Lightweight homelab deployments | ~180 MB | ~17 MB |
| **FrankenPHP** | High-performance production | ~230 MB | ~200 MB |

## Variants

### PHP-FPM

Lightweight Alpine-based image with PHP-FPM and Nginx. Ideal for homelab environments where resources are constrained and memory usage matters more than maximum performance.

### FrankenPHP

Modern PHP application server built on Caddy. Designed for high-performance production deployments where request speed is critical. Uses Laravel Octane for persistent worker processes.


## Quick Start

### PHP-FPM

```bash
docker build -t myapp-fpm -f Dockerfile.fpm .
docker run -p 8080:8080 -v $(pwd)/data:/data myapp-fpm
```

### FrankenPHP

```bash
docker build -t myapp-frankenphp -f Dockerfile.frankenphp .
docker run -p 8080:8080 -v $(pwd)/data:/data myapp-frankenphp
```

## Configuration

### Environment Variables

Both images share the same core configuration:

| Variable | Default | Description |
|----------|---------|-------------|
| `APP_ENV` | `production` | Application environment |
| `APP_DEBUG` | `false` | Debug mode toggle |
| `LOG_CHANNEL` | `stderr` | Log output destination |
| `DB_CONNECTION` | `sqlite` | Database driver |
| `DB_DATABASE` | `/data/database.sqlite` | SQLite database path |

### FrankenPHP Additional Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `OCTANE_WORKERS` | `2` | Number of Octane worker processes |

### Volumes

Mount the following volumes for persistence:

| Path | Purpose |
|------|---------|
| `/data` | SQLite database storage |


## Performance Comparison

### Resource Usage

| Metric | PHP-FPM | FrankenPHP | Difference |
|--------|---------|------------|------------|
| Image Size | ~180 MB | ~230 MB | +50 MB |
| Idle Memory | ~17 MB | ~200 MB | +183 MB |
| Startup Time | Fast | Moderate | - |
| Worker Model | Process pool | Persistent workers | - |
| Best For | Homelab | Production | - |

### When to Use Each

**Choose PHP-FPM when:**
- Running on limited hardware (Raspberry Pi, NAS, old servers)
- Memory efficiency is critical
- Single application deployments
- Quick scaling not required

**Choose FrankenPHP when:**
- Maximum request performance is required
- High traffic applications
- Modern PHP features (async, workers) are utilized
- Automatic HTTPS is desired
- Persistent connections are beneficial

## Included Configuration

### PHP-FPM
- Nginx configuration for Laravel
- PHP-FPM pool optimized for single app
- OPcache settings for production
- Entrypoint script for initialization

### FrankenPHP
- Caddyfile for Laravel Octane
- Health check endpoint
- Automatic HTTPS support
- Entrypoint script for initialization

## Security

Built on Wolfi Linux, an independent Linux distribution designed for security:
- Minimal attack surface
- Regular security updates
- Chaotic engineering principles
- Reproducible builds

## Requirements

- Docker 20.10+
- SQLite-compatible Laravel application
- For multi-stage builds: Docker BuildKit enabled

## Building

```bash
# Enable BuildKit
export DOCKER_BUILDKIT=1

# Build PHP-FPM variant
docker build -t myapp-fpm -f Dockerfile.fpm .

# Build FrankenPHP variant
docker build -t myapp-frankenphp -f Dockerfile.frankenphp .
```

## License

MIT License
