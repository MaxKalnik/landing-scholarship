# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'landing_scholarship'
set :repo_url, 'git@github.com:rewardexpert/landing-scholarship.git'

# Default branch is :master
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, proc { "/home/reward/#{fetch :application}" }

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
set :format, :airbrussh

set :rails_env, 'production'
# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml','config/secrets.yml'
append :linked_files, '.env'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
set :rvm_ruby_version, '2.2.1'
#set :puma_conf, "#{release_path}/config/puma.rb"
set :puma_threads, [5, 10]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, true

set :slackistrano, {
  channel: '#deploy',
  team: 'rewardexpert',
  token: 'WwCywYkBfaUrkVuQZJgz78qm'
}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
