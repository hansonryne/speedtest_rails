#!/bin/sh
echo "Installing new gems if needed"
bundle check || bundle install

echo "Copying node cache"
#rsync -av /node_cache/. /app/

echo "Creating database..."
bundle exec rake db:create
echo "Running database migrations..."
bundle exec rake db:migrate

echo "Precompiling webpack assets"
bundle exec rake assets:precompile

echo "Getting cron jobs ready..."
bundle exec wheneverize .

echo "Starting background jobs"
bundle exec whenever --update-crontab
crond -b

echo "Your background jobs look like:"
crontab -l

echo "Your ongoing processes:"
ps aux

echo "Removing any old server pids"
rm -f /app/tmp/pids/server.pid

echo "Starting rails server"
bundle exec rails s -b 0.0.0.0
