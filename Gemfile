source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.3'
ruby '2.2.1'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Icons
gem 'themify-icons-rails' # Themify
# gem 'font-awesome-rails', '~> 4.3' # Font Awesome

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Allow haml files
gem 'haml'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Jquery Form Validations
gem 'jquery-validation-rails'
# Ruby Date Validations
gem 'jc-validates_timeliness'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Supplement to Turbolinks so the template works
# gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Accounts & Authentication
gem 'devise', '~> 3.4'

# Twilio Messages
gem 'twilio-ruby'
# Stripe Payouts
gem 'stripe'

# Select JS & CSS
gem 'selectize-rails'

# Active Jobs ( using DelayedJob )
#gem 'resque'
#gem 'resque-scheduler'
gem 'delayed_job_active_record'

# Development emails
gem 'letter_opener', group: :development

# Use Unicorn as the app server
gem 'unicorn'

# Deployment Details (Use Capistrano for deployment)
group :development do
    gem 'capistrano',         require: false
    gem 'capistrano-rvm',     require: false
    gem 'capistrano-rails',   require: false
    gem 'capistrano-rails-collection', require: false
    gem 'capistrano-bundler', require: false
    gem 'capistrano3-unicorn', require: false
end
