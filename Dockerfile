FROM ruby:3.0
LABEL maintainer="nfq <nfq.fajri@ymail.com>"
RUN gem install rspec capybara selenium-webdriver
COPY spec /tests
# This is an example of an ENTRYPOINT in command form.
ENTRYPOINT [ "rspec" ]
# And this is an example of an ENTRYPOINT in shell form.
# ENTRYPOINT "rspec".
