rails_env = ENV['RAILS_ENV'] || 'production'
NAME = "fruitwood"
app_path = "/u/apps/#{NAME}/current"

threads 4,4

#bind  "unix:///data/apps/appname/shared/tmp/puma/appname-puma.sock"
bind "tcp://127.0.0.1:10000"
pidfile "#{app_path}/tmp/puma/pid"
state_path "#{app_path}/current/tmp/puma/state"

activate_control_app
