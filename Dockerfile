# Dockerfile

# Use the official Ruby image
FROM ruby:3.0

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gem dependencies
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Run the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
