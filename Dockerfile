# Use the official Ruby image
FROM ruby:3.0

# Install Jekyll and Bundler
RUN gem install jekyll bundler

# Set the working directory to /app
WORKDIR /app

# Copy your Jekyll project files into the container
COPY . .

# Install dependencies
RUN bundle install

# Expose port 4000 (Jekyll default)
EXPOSE 4000

# Command to run Jekyll
CMD ["jekyll", "serve", "--host", "0.0.0.0"]