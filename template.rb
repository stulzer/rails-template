def get_file(file)
  get "#{template_url}/#{file}", file
end

def template_url
  'https://raw.githubusercontent.com/stulzer/rails-template/rails-5'
end

run 'rm Gemfile config/locales/en.yml config/database.yml'

initializer 'generators.rb', <<-CODE
module #{app_name.gsub(/-/, '_').camelize}
  class Application < Rails::Application
    config.generators do |g|
      g.test_framework :rspec, fixture: false, views: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
CODE

initializer 'action_mailer.rb', <<-CODE
module #{app_name.gsub(/-/, '_').camelize}
  class Application < Rails::Application
    config.action_mailer.default_url_options = { host: 'localhost:3000' }
  end
end
CODE

initializer 'internationalization.rb', <<-CODE
module #{app_name.gsub(/-/, '_').camelize}
  class Application < Rails::Application
    config.time_zone = 'Brasilia'
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/*.{rb,yml}').to_s]
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = [:en, :'pt-BR']
    config.i18n.default_locale = :'pt-BR'
  end
end
CODE

initializer 'asset_pipeline.rb', <<-CODE
module #{app_name.gsub(/-/, '_').camelize}
  class Application < Rails::Application
    config.assets.precompile += ['.svg', '.eot', '.woff', '.ttf']
  end
end
CODE

get_file 'Gemfile'
get_file 'config/database.yml'

# locales
get_file 'config/locales/pt-BR/rails.yml'
get_file 'config/locales/pt-BR/app.yml'

# bundling
run 'bundle install'

inject_into_file 'config/database.yml', after: 'port: 5432' do <<-CODE

development:
  <<: *defaults
  database: #{app_name.gsub(/-/, '_')}_development

test: &test
  <<: *defaults
  database: #{app_name.gsub(/-/, '_')}_test
CODE
end

# rspec
generate 'rspec:install'

# Improve README
get_file 'README.md_example'
run 'rm README.md'
run 'mv README.md_example README.md'
get_file '.editorconfig'

# init guard
run 'bundle exec guard init livereload'

run 'mv spec/spec_helper.rb spec/.spec_helper_backup'
get_file 'spec/spec_helper.rb'

run 'mv spec/rails_helper.rb spec/.rails_helper_backup'
get_file 'spec/rails_helper.rb'

run 'bundle binstubs rspec-core'
run 'bundle binstubs rubocop'

rake 'db:create'
rake 'db:migrate'

# git
git :init
git add: '.'
git commit: %Q{ -m 'First commit' }

puts '=================================='
puts 'CHECK SPECS HELPERS spec/rails_helper.rb spec/rails_helper.rb'
