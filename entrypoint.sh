#!/bin/sh

echo "Copying node cache"
rsync -av /node_cache/. /app/
echo "Starting rails server"
exec rails s -b 0.0.0.0
