# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.0.2
FROM ruby:$RUBY_VERSION-slim

# Rails app lives here
WORKDIR /rails

# Set development environment
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="production"

# Install packages needed for gems and SQLite
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config libsqlite3-0 sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=4 --retry=3

# Copy application code
COPY . .

# Run and own only the runtime files as a non-root user for security
RUN useradd -m rails && \
    chown -R rails:rails /rails
USER rails:rails

# Expose port 5000
EXPOSE 5000

# Run migrations and then start the server with logs
CMD ["bash", "-c", "echo 'Running migrations...' && bundle exec rails db:migrate && echo 'Starting Rails server...' && bundle exec rails server -b 0.0.0.0 -p 5000"]
