def get_file(file)
  get "#{template_url}/#{file}", file
end

def template_url
  "https://github.com/stulzer/rails-template/raw/dmi-template"
end

run "rm Gemfile app/views/layouts/application.html.erb config/database.yml app/assets/stylesheets/application.css app/assets/javascripts/application.js"

get_file "Gemfile"

# application layout and helper
get_file "app/views/layouts/application.html.erb"

# basic sass files
get_file "app/assets/stylesheets/utils/_normalize.scss"
get_file "app/assets/stylesheets/utils/_bootstrap.scss"
get_file "app/assets/stylesheets/utils/_functions.scss"
get_file "app/assets/stylesheets/utils/_mixins.scss"
get_file "app/assets/stylesheets/application.css"
get_file "app/assets/stylesheets/application-module.scss"

# basic js files
get_file "app/assets/javascripts/application.js"
get_file "app/assets/javascripts/bootstrap.js"

# basic db configuration
get_file "config/database.yml"

# aditional assets files

application <<-GENERATORS
  config.generators do |g|
    g.test_framework :rspec, fixture: false, views: false
    g.fixture_replacement :factory_girl, dir: "spec/factories"
  end

  config.action_mailer.default_url_options = { host: "localhost:3000" }
GENERATORS

# bundling
run "bundle install"

# rspec
generate "rspec:install"

# init guard
run "bundle exec guard init livereload"

run "mv spec/spec_helper.rb spec/.spec_helper_backup"
get_file "spec/spec_helper.rb"

run "mv spec/rails_helper.rb spec/.rails_helper_backup"
get_file "spec/rails_helper.rb"

run "bundle binstubs rspec-core"
run "bundle binstubs guard"

# git
git :init

puts "=================================="
puts "CONFIGURE THE DATABASE.YML"
puts "CHECK SPECS HELPERS spec/rails_helper.rb spec/rails_helper.rb"
