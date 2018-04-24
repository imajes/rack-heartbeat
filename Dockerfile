FROM ruby:2.2

WORKDIR /usr/src/app

COPY Gemfile* ./
COPY *.gemspec ./
RUN bundle install

COPY . .

# CMD ["./your-daemon-or-script.rb"]