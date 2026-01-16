#!/bin/sh
set -eu

if [ "${DB_CONNECTION:-}" = "sqlite" ] && [ ! -f "${DB_DATABASE:-/data/database.sqlite}" ]; then
    mkdir -p "$(dirname "${DB_DATABASE:-/data/database.sqlite}")"
    touch "${DB_DATABASE:-/data/database.sqlite}"
    echo "Created SQLite database"
fi

echo "Running migrations..."
php artisan migrate --force

echo "Optimizing..."
php artisan optimize

echo "Creating storage link..."
php artisan storage:link 2>/dev/null || true

echo "Starting application..."
exec "$@"
