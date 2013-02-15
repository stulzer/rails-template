def get_file(file)
  get "#{template_url}/#{file}", file
end

def template_url
  "https://github.com/stulzer/rails-template/raw/master"
end

run "rm Gemfile app/views/layouts/application.html.erb app/helpers/application_helper.rb app/assets/stylesheets/application.css"

get_file 'Gemfile'

# locales
get_file "config/locales/rails.pt-BR.yml"
get_file "config/locales/rails.en.yml"
get_file "config/locales/devise.views.pt-BR.yml"
get_file "config/locales/devise.views.en.yml"

# application layout and helper
get_file "app/views/layouts/application.html.erb"
get_file "app/helpers/application_helper.rb"

# error_messages_for
run "mkdir -p app/views/shared"
get_file "app/views/shared/_error_messages.html.erb"

# basic sass files
get_file "app/assets/stylesheets/normalize.css.scss"
get_file "app/assets/stylesheets/bootstrap/functions.css.scss"
get_file "app/assets/stylesheets/bootstrap/mixins.css.scss"
get_file "app/assets/stylesheets/bootstrap/sprites.css.scss"
get_file "app/assets/stylesheets/tablet.css.scss"
get_file "app/assets/stylesheets/mobile.css.scss"
get_file "app/assets/stylesheets/mobile-wide.css.scss"
get_file "app/assets/stylesheets/application.css"
get_file "app/assets/stylesheets/application-module.css.scss"

# basic admin images files
run "mkdir app/assets/images/admin"
get_file "app/assets/images/admin/bg-sep.gif"
get_file "app/assets/images/admin/bg.gif"
get_file "app/assets/images/admin/menu-bg-y.gif"
get_file "app/assets/images/admin/menu-bg.gif"

# basic admin assets
get_file "app/assets/stylesheets/admin/module.css.scss"
get_file "app/assets/javascripts/admin/module.js"
get_file "app/views/layouts/admin.html.erb"

# basic admin controllers
run "mkdir -p app/controllers/admin"
get_file "app/controllers/admin/base_controller.rb"

# admin helper
get_file "app/helpers/admin_helper.rb"

# adding basic admin fonts
run "mkdir -p app/assets/fonts/entypo"
get_file "app/assets/fonts/entypo/entypo.eot"
get_file "app/assets/fonts/entypo/entypo.svg"
get_file "app/assets/fonts/entypo/entypo.ttf"
get_file "app/assets/fonts/entypo/entypo.woff"
get_file "app/assets/fonts/entypo/entypo-social.eot"
get_file "app/assets/fonts/entypo/entypo-social.svg"
get_file "app/assets/fonts/entypo/entypo-social.ttf"
get_file "app/assets/fonts/entypo/entypo-social.woff"

# aditional assets files
inject_into_file "config/application.rb",
  "\n\n\n    # aditional assets \n    config.assets.precompile += [ 'html5.js', 'admin/module.js', 'admin/module.css', '.svg', '.eot', '.woff', '.ttf' ]\n    # Fonts path \n    config.assets.paths << '\#{Rails.root}/app/assets/fonts'",
  :after => "config.assets.enabled = true"

# creating presenters
run "mkdir app/presenters"
get_file "app/presenters/base_presenter.rb"

# basic icons images files
run "mkdir app/assets/images/icons"
get_file "app/assets/images/icons/block_16.png"
get_file "app/assets/images/icons/block_32.png"
get_file "app/assets/images/icons/tick_16.png"
get_file "app/assets/images/icons/tick_32.png"
get_file "app/assets/images/icons/warning_16.png"
get_file "app/assets/images/icons/warning_32.png"

# basic js files
get_file "app/assets/javascripts/html5.js"
run "curl https://raw.github.com/jzaefferer/jquery-validation/master/jquery.validate.js > vendor/assets/javascripts/jquery.validate.js"
run "mkdir -p vendor/assets/javascripts/validate/localization"
get_file "vendor/assets/javascripts/validate/localization/messages_pt_BR.js"

# rspec
generate "rspec:install"

# jasmine
generate "jasmine:install"

# init compass and guard
run "bundle exec compass init"
run "bundle exec guard init rspec"
run "bundle exec guard init livereload"
run "bundle exec guard init jasmine"

run "rm app/assets/stylesheets/screen.css.scss app/assets/stylesheets/print.css.scss app/assets/stylesheets/ie.css.scss"

# removing index
run "rm public/index.html"

application <<-GENERATORS
config.generators do |g|
  g.test_framework :rspec, :fixture => false, :views => false
  g.fixture_replacement :factory_girl, :dir => "spec/factories"
end

config.action_mailer.default_url_options = { :host => "localhost:3000" }

GENERATORS

# git

git :init
git :add => '.'
git :commit => '-am "Initial commit"'

puts "=================================="
puts "FINISHED"
