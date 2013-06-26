def get_file(file)
  get "#{template_url}/#{file}", file
end

def template_url
  "https://github.com/stulzer/rails-template/raw/master"
end

run "rm Gemfile app/views/layouts/application.html.erb app/helpers/application_helper.rb app/assets/stylesheets/application.css config/locales/en.yml"

get_file "Gemfile"

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
get_file "app/assets/stylesheets/tablet.css.scss"
get_file "app/assets/stylesheets/mobile.css.scss"
get_file "app/assets/stylesheets/mobile-wide.css.scss"
get_file "app/assets/stylesheets/application.css"
get_file "app/assets/stylesheets/application-module.css.scss"

# basic admin assets
get_file "app/assets/stylesheets/admin/module.css.scss"
get_file "app/assets/stylesheets/admin/_vars.css.scss"
get_file "app/assets/stylesheets/admin/_normalize.css.scss"
get_file "app/assets/stylesheets/admin/_meny.css.scss"
get_file "app/assets/stylesheets/admin/_font-awesome.css.scss"
get_file "app/assets/stylesheets/admin/_header.css.scss"
get_file "app/assets/stylesheets/admin/_nav.css.scss"
get_file "app/assets/stylesheets/admin/_index.css.scss"
get_file "app/assets/stylesheets/admin/_buttons.css.scss"
get_file "app/assets/stylesheets/admin/_forms.css.scss"

get_file "app/assets/javascripts/admin/module.js"
get_file "app/assets/javascripts/admin/meny.js"
get_file "app/views/layouts/admin.html.erb"

# basic admin controllers
run "mkdir -p app/controllers/admin"
get_file "app/controllers/admin/base_controller.rb"
get_file "app/controllers/admin/passwords_controller.rb"
get_file "app/controllers/admin/sessions_controller.rb"
get_file "app/controllers/admin/unlocks_controller.rb"

# admin helper
get_file "app/helpers/admin_helper.rb"

# adding basic admin fonts
run "mkdir -p app/assets/fonts/fontawesome"
get_file "app/assets/fonts/fontawesome/fontawesome-webfont.eot"
get_file "app/assets/fonts/fontawesome/fontawesome-webfont.svg"
get_file "app/assets/fonts/fontawesome/fontawesome-webfont.ttf"
get_file "app/assets/fonts/fontawesome/fontawesome-webfont.woff"

# aditional assets files
inject_into_file "config/application.rb",
  "\n\n\n    config.time_zone = \"Brasilia\" \n    config.i18n.available_locales = [:en, :\"pt-BR\"] \n    config.i18n.default_locale = :\"pt-BR\" \n\n\n\n    # aditional assets \n    config.assets.precompile += [ 'html5.js', 'admin/module.js', 'admin/module.css', '.svg', '.eot', '.woff', '.ttf' ]\n    # Fonts path \n    config.assets.paths << Rails.root.join(\"app\", \"assets\", \"fonts\")",
  :after => "# config.time_zone = 'Central Time (US & Canada)'"

# admin routes
inject_into_file "config/routes.rb",
  "     devise_for :admins, :controllers => {
    :sessions  => 'admin/sessions',
    :passwords => 'admin/passwords',
    :unlocks   => 'admin/unlocks'
  }

  namespace :admin do
    resources :admins
    root :to => 'admins#index'
  end",
  :before => "# The priority is based upon order of creation: first created -> highest priority."

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
get_file "app/assets/javascripts/jquery.validate.js"
run "mkdir -p app/assets/javascripts/validate/localization"
get_file "app/assets/javascripts/validate/localization/messages_pt_BR.js"

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

# bundling
run "bundle install"

# rspec
generate "rspec:install"

# devise
generate "devise:install"

# init guard
run "bundle exec guard init livereload"

puts "=================================="
puts "FINISHED"
