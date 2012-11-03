def get_file(file)
  get "#{template_url}/#{file}", file
end

def template_url
  "https://github.com/stulzer/rails-template/raw/master"
end

run "rm Gemfile app/views/layouts/application.html.erb app/helpers/application_helper.rb app/assets/stylesheets/application.css"

get_file 'Gemfile'
run 'bundle install'

# locales
get_file "config/locales/rails.pt-BR.yml"
get_file "config/locales/rails.en.yml"
get_file "config/locales/devise.pt-BR.yml"
get_file "config/locales/devise.en.yml"

# application layout and helper
get_file "app/views/layouts/application.html.erb"
get_file "app/helpers/application_helper.rb"

# error_messages_for
run "mkdir -p app/views/shared"
get_file "app/views/shared/_error_messages.html.erb"

# basic sass files
get_file "app/assets/stylesheets/reset.css.scss"
get_file "app/assets/stylesheets/bootstrap/functions.css.scss"
get_file "app/assets/stylesheets/bootstrap/mixins.css.scss"
get_file "app/assets/stylesheets/bootstrap/sprites.css.scss"
get_file "app/assets/stylesheets/tablet.css.scss"
get_file "app/assets/stylesheets/mobile.css.scss"
get_file "app/assets/stylesheets/mobile-wide.css.scss"
get_file "app/assets/stylesheets/application.css"
get_file "app/assets/stylesheets/application-module.css.scss"

# compass stuff
run "bundle exec compass init"
run "rm app/assets/stylesheets/screen.css.scss app/assets/stylesheets/print.css.scss app/assets/stylesheets/ie.css.scss"

# basic js files
get_file "app/assets/javascripts/html5.js"
run "curl https://raw.github.com/jzaefferer/jquery-validation/master/jquery.validate.js > vendor/assets/javascripts/jquery.validate.js"
run "mkdir -p vendor/assets/javascripts/validate/localization"
get_file "vendor/assets/javascripts/validate/localization/messages_pt_BR.js"

# guard configuration
get_file "Guardfile"

# rspec
generate "rspec:install"

# jasmine
generate "jasmine:install"

# removing index
run "rm public/index.html"

application <<-GENERATORS
config.generators do |g|
  g.test_framework :rspec, :fixture => false, :views => false
  g.fixture_replacement :factory_girl, :dir => "spec/support/factories"
end

config.action_mailer.default_url_options = { :host => "localhost:3000" }

GENERATORS

# git

git :init
git :add => '.'
git :commit => '-am "Initial commit"'

puts "=================================="
puts "FINISHED"
