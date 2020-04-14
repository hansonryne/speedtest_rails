FROM my-ruby-alpine

# Create and define the node_modules's cache directory.
RUN mkdir /node_cache
WORKDIR /node_cache

# Install the application's dependencies into the node_modules's cache directory.
COPY package.json ./
RUN yarn install

# Create and define the application's working directory.
WORKDIR /app
