#!/bin/sh

echo "Copying node cache"
rsync -av /node_cache/. /app/

echo "Creating database..."
rake db:create
echo "Running database migrations..."
rake db:migrate

echo "You may also want to precompile assets"
echo "Comment out the rake task in this file if this is the case"
rake assets:precompile

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

echo "Starting rails server"
exec rails s -b 0.0.0.0
