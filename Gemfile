# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.3"

gem "bcrypt"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap"
gem "carrierwave"
gem "coffee-rails", "~> 4.2"
gem "fog-aws"
gem "font-awesome-rails"
gem "geocoder"
gem "html2slim"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "pry-byebug"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.3"
gem "rails-i18n", "~> 5.1"
gem "rmagick"
gem "sass-rails", "~> 5.0"
gem "slim-rails"
gem "toastr-rails"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "rspec-rails"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rubocop", require: false
  gem "rubocop-github"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "launchy"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
