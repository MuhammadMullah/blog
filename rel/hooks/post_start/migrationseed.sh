##!/bin

echo "Running migrations and seed data if any"
# bin/docker_magic  migrate
release_ctl eval --mfa "Blog.ReleaseTasks.seed/1" --argv -- "$@"
echo "Migrations and Seed data run successfully"
