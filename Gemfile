source 'https://rubygems.org'
ruby '2.0.0'

#global
gem 'rails', '4.0.0.beta1'
gem 'bootstrap-sass', '2.3.0.1'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '2.13.0'
  gem 'spork-rails', git: 'git://github.com/A-gen/spork-rails.git'
end

group :test do
  gem 'selenium-webdriver', '2.0'
  gem 'capybara', '2.1.0.beta1'
  gem 'factory_girl_rails', '4.2.0'
end

group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'
  gem 'uglifier', '>= 1.0.3'
end

#for heroku
group :production do
  gem 'pg', '0.14.1'
end