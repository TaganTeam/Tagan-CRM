
set :repo_url,        'git@github.com:TaganTeam/Tagan-CRM.git'
set :application,     'Tagan-CRM'
set :user,            'nikolay'
set :use_sudo, false
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: File.join(ENV["HOME"], ".ssh", "id_rsa") }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord




# set :precompile_cmd             # default: bundle exec rake assets:precompile

# set :npm_target_path, -> { release_path.join('subdir') } # default not set
set :npm_flags, '--production --silent --no-progress'    # default
set :npm_roles, :all                                     # default
set :npm_env_variables, {}                               # default

set :bower_flags, '--quiet --config.interactive=false'
set :bower_roles, :web
# set :bower_target_path, nil
set :bower_bin, :bower


## Defaults:
# set :scm,           :git
set :branch,        '26-07-TaganCRM'
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5
set(:config_files, %w(
  nginx.conf
  database.yml
  log_rotation
  monit
  unicorn.rb
  unicorn_init.sh
))

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

set :linked_files, %w{config/database.yml config/secrets.yml public/manifest.yml}
## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      # unless `git rev-parse HEAD` == `git rev-parse origin/master`
      #   puts "WARNING: HEAD is not the same as origin/master"
      #   puts "Run `git push` to sync changes."
      #   exit
      # end
    end
  end


  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart

end


# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma