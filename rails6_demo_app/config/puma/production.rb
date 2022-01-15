rails_env = "production"

environment rails_env



app_dir = "/opt/app" # Update me with your root rails app path


bind  "unix://#{app_dir}/puma.sock"

pidfile "#{app_dir}/tmp/pids/puma.pid"

state_path "#{app_dir}/tmp/pids/puma.state"

directory "#{app_dir}/"

stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true



workers 2

threads 1,2

port ENV.fetch("PORT") { 3000 }

activate_control_app "unix://#{app_dir}/pumactl.sock"



prune_bundler