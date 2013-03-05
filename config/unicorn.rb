# encoding: utf-8
# Set your full path to application.
application = 'fruitwood'
app_path = "/u/apps/#{application}"
shared_path = "#{app_path}/shared"
current_path = "#{app_path}/current"

# Set unicorn options
worker_processes 4
preload_app true   # Preload our app for more speed
timeout 180
listen 9000
#listen "/tmp/unicorn.fruitwood.sock"

# Spawn unicorn master worker for user apps (group: apps)
user ENV['USER'] || 'ruby', ENV['USER'] || 'ruby'

# Fill path to your app
working_directory current_path

# Should be 'production' by default, otherwise use other env 
rails_env = ENV['RAILS_ENV'] || 'production'

# Log everything to one file
stderr_path "log/unicorn.log"
stdout_path "log/unicorn.log"

# Set master PID location
pid "#{current_path}/tmp/pids/unicorn.pid"
#pid "#{shared_path}/pids/unicorn.pid"

if GC.respond_to?(:copy_on_write_friendly=)
    GC.copy_on_write_friendly = true
end

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end

# 修正无缝重启unicorn后更新的Gem未生效的问题，原因是config/boot.rb会优先从ENV中获取BUNDLE_GEMFILE，而无缝重启时ENV['BUNDLE_GEMFILE']的值并未被清除，仍指向旧目录的Gemfile
before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{current_path}/Gemfile"
end
