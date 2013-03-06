rails_env = ENV['RAILS_ENV'] || 'production'
NAME = "fruitwood"
app_path = "/u/apps/#{NAME}/current"

threads 4,4

activate_control_app
#bind  "unix:///tmp/puma.#{NAME}.sock"
bind "tcp://127.0.0.1:10000"
#pidfile "#{app_path}/tmp/puma/pid"
#state_path "#{app_path}/tmp/puma/state"
rackup "#{app_path}/config.ru"
