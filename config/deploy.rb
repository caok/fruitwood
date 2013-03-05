# encoding: utf-8
# add config/deploy to load_path
$: << File.expand_path('../deploy/', __FILE__)

require 'bundler/capistrano'
require 'capistrano_database'

set :application, "fruitwood"
#set :repository, "git://github.com/caok/fruitwood.git"
#set :branch, "master"
set :repository, ENV['REPO'] || File.expand_path('../../.git/', __FILE__)

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/u/apps/#{application}" # default
set :deploy_via, :remote_cache # 不要每次都获取全新的repository

set :user, ENV['DEPLOY_USER'] || ENV['USER'] || "ruby"
set :use_sudo, true
default_run_options[:pty] = true

set :rbenv_version, ENV['RBENV_VERSION'] || "1.9.3-p392"
set :default_environment, {
  'PATH' => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH",
  'RBENV_VERSION' => "#{rbenv_version}",
}

set :deploy_server, ENV['DEPLOY_SERVER'] || 'localhost'

role :web, "#{deploy_server}"                          # Your HTTP server, Apache/etc
role :app, "#{deploy_server}"                          # This may be the same as your `Web` server
role :db,  "#{deploy_server}", :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

namespace :deploy do
  namespace :assets do
    desc "deploy the precompiled assets"
    task :precompile, :roles => :web, :except => { :no_release => true } do
      run_locally("bundle exec rake assets:clean assets:precompile RAILS_ENV=#{rails_env} #{asset_env}")
      top.upload("public/assets", "#{release_path}/public/", :via => :scp, :recursive => true)
      run_locally("rm -rf public/assets")
    end
  end

  %w(start stop restart).each do |action|
    desc "puma:#{action}"
    task action.to_sym do
       find_and_execute_task("puma:#{action}")
    end
  end

  task :chown, :roles => :app do
    run "#{try_sudo} chown -R #{user}:#{user} #{deploy_to}"
  end

  desc "create db:seed"
  task :seed, :roles => :app do
    run "cd #{current_path} && rake db:seed RAILS_ENV=#{rails_env}"
  end
end

namespace :puma do
  desc "Start Puma"
  task :start, :except => { :no_release => true } do
    run "#{try_sudo}/etc/init.d/puma start #{application}"
  end
  after "deploy:start", "puma:start"

  desc "Stop Puma"
  task :stop, :except => { :no_release => true } do
    run "#{try_sudo}/etc/init.d/puma stop #{application}"
  end
  after "deploy:stop", "puma:stop"

  desc "Restart Puma"
  task :restart, roles: :app do
    run "#{try_sudo}/etc/init.d/puma restart #{application}"
  end
  after "deploy:restart", "puma:restart"

  desc "create a shared tmp dir for puma state files"
  task :after_symlink, roles: :app do
    run "#{try_sudo} rm -rf #{release_path}/tmp"
    run "ln -s #{shared_path}/tmp #{release_path}/tmp"
  end
  after "deploy:create_symlink", "puma:after_symlink"
end


namespace :carrierwave do
  desc "Symlink the upload files"
  task :symlink, :roles => [:app] do
    run "mkdir -p #{shared_path}/uploads && ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
end

before "db:setup", "deploy:chown"
after 'deploy:update', 'carrierwave:symlink'

#require 'capistrano-unicorn'

#after 'deploy:start', 'unicorn:start'
#after 'deploy:stop', 'unicorn:stop'
