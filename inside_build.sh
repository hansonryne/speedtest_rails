#!/bin/bash

# Run this with
# docker exec tt_app_1 /app/inside_build.sh

echo "Creating database..."
rake db:create
echo "Running database migrations..."
rake db:migrate

echo "You may also want to precompile assets"
echo "Comment out the rake task in this file if this is the case"
#rake precompile:assets

echo "Getting cron jobs ready..."
bundle exec wheneverize .
echo "Starting background jobs"
bundle exec whenever --update-crontab
crond -b
echo "Your background jobs look like:"
crontab -l
echo "Your ongoing processes:"
ps aux
echo "Done!"

