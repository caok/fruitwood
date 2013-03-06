#source 'https://rubygems.org'
source 'http://ruby.taobao.org/'

gem 'rails', '3.2.12'
gem 'mysql2'

gem 'simple_form'
gem 'html-pipeline-no-charlock'
gem 'has_html_pipeline'
gem 'slim-rails'
gem 'kaminari'
gem 'devise'
gem 'cancan'
# attachment
gem 'carrierwave'
gem 'mini_magick'
gem 'puma'

group :assets do
  gem 'sass-rails',     '~> 3.2.3'
  gem 'coffee-rails',   '~> 3.2.1'
  gem 'uglifier',       '>= 1.0.3'
  gem 'jquery-rails'
  gem 'bootstrap-datepicker-rails'
  gem 'bootstrap-sass', '~> 2.2.2.0'
  gem 'jquery-fileupload-rails'
  gem 'therubyracer', '~> 0.11.2'
  gem 'turbo-sprockets-rails3'
end

group :development, :test do
  gem 'capybara'
  gem 'rspec-rails'
  gem 'jasmine', '~> 1.3.1'
  gem 'factory_girl_rails', '~> 4.0'
end

group :development do
  gem 'thin'
  gem 'pry-nav'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'capistrano-unicorn', :require => false
end

group :production do
  gem 'puma'
  gem 'unicorn'
  gem 'exception_notification'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# To use debugger
# gem 'debugger'
