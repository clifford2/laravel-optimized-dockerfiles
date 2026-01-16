# Laravel Dockerfiles

Optimized and secure Docker images for Laravel applications with SQLite. Two variants designed for different deployment scenarios, both built on Wolfi Linux for enterprise-grade security.

## Overview

This repository provides production-ready Docker images built on **Wolfi Linux**, an independent Linux distribution designed from the ground up for security. These images deliver maximum performance without compromising on safety.

| Variant | Use Case | Image Size | Idle Memory |
|---------|----------|------------|-------------|
| **PHP-FPM** | Lightweight homelab deployments | ~180 MB | ~17 MB |
| **FrankenPHP** | High-performance production | ~230 MB | ~200 MB |

### Core Design Goals

**Performance**
- Multi-stage builds for minimal image size
- Pre-configured OPcache and worker optimization
- Frontend assets compiled during build time

**Security**
- Built on Wolfi Linux
- Minimal attack surface with stripped-down packages

## Variants

### PHP-FPM

Lightweight image with PHP-FPM and Nginx. Ideal for homelab environments where resources are constrained and memory efficiency matters more than maximum performance.

**Key Features:**
- Multi-stage build with frontend compilation
- Pre-configured PHP-FPM pool settings
- OPcache enabled for optimal performance
- SQLite database support out of the box
- Wolfi security foundation

### FrankenPHP

Modern PHP application server built on Caddy. Designed for high-performance production deployments where request speed is critical. Uses Laravel Octane for persistent worker processes.

**Key Features:**
- Laravel Octane workers for persistent execution
- Pre-warmed OPcache
- Wolfi security foundation

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
| Worker Model | On demand process pool | Persistent workers | - |
| Best For | Homelab | Production | - |

### When to Use Each

**Choose PHP-FPM when:**
- Running on limited hardware (Raspberry Pi, NAS, old servers)
- Memory efficiency is critical

**Choose FrankenPHP when:**
- High traffic applications

## Security

These images are built on **Wolfi Linux**, an independent Linux distribution designed specifically for security in cloud-native environments.


## License

MIT License
