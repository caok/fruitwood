# encoding: utf-8
# add config/deploy to load_path
$: << File.expand_path('../deploy/', __FILE__)

require 'bundler/capistrano'
require 'capistrano_database'

set :application, "fruitwood"
#set :repository, "git://github.com/caok/fruitwood.git"
set :repository, ENV['REPO'] || File.expand_path('../../.git/', __FILE__)
set :branch, "master"

set :scm, :git

set :deploy_to, "/u/apps/#{application}" # default
set :deploy_via, :remote_cache # 不要每次都获取全新的repository

set :user, ENV['DEPLOY_USER'] || ENV['USER'] || "rails"
set :use_sudo, true
default_run_options[:pty] = true

set :bundle_without,  [:development, :test]

set :rbenv_version, ENV['RBENV_VERSION'] || "2.0.0-p247"
set :default_environment, {
  'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH",
  'RBENV_VERSION' => "#{rbenv_version}",
}

set :deploy_server, ENV['DEPLOY_SERVER'] || 'localhost'

role :web, "#{deploy_server}"                          # Your HTTP server, Apache/etc
role :app, "#{deploy_server}"                          # This may be the same as your `Web` server
role :db,  "#{deploy_server}", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  desc "Start Application"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop Application"
  task :stop, :roles => :app do
    run "kill -QUIT `cat #{shared_path}/pids/unicorn.#{application}.pid`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{shared_path}/pids/unicorn.#{application}.pid`"
  end

  task :chown, :roles => :app do
    run "#{try_sudo} chown -R #{user}:#{user} #{deploy_to}"
  end

  desc "Populates the Production Database"
  task :seed do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:seed"
  end
end

namespace :carrierwave do
  desc "Symlink the upload files"
  task :symlink, :roles => [:app] do
    run "mkdir -p #{shared_path}/uploads && ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

before "db:setup", "deploy:chown"
after 'deploy:update', 'carrierwave:symlink'
