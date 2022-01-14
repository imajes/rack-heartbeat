FROM registry.tld/cyberark/ubuntu-ruby-fips:latest

WORKDIR /usr/src/app

COPY Gemfile* ./
COPY *.gemspec ./
RUN bundle install

COPY . .

# CMD ["./your-daemon-or-script.rb"]
