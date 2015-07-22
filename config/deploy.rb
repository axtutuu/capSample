# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'kayacInternApp'
set :repo_url, 'git@gitlab.develop-spot.com:A.K/kayacInternApp.git'
set :deploy_to, '/var/www/'
set :scm, :git
set :keep_releases, 5

# rbenvの設定
set :default_env, {
  rbenv_root: "/opt/rbenv/",
  path: "/opt/rbenv/shims:/opt/rbenv/bin:$PATH"
}

# Unicorn周りの設定
set :unicorn_rack_env, "none"
set :unicorn_config_path, "config/unicorn.rb"
set :unicorn_pid, "/tmp/unicorn_kayacInternApp.pid"

# currentからsharedへsymlinkを貼るものを指定
set :linked_dirs, %w{bin bundle log tmp/pids tmp/cache tmp/sockets public/system}

# logを詳細表示
set :format, :pretty
set :log_level, :debug

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:legacy_restart'
  end

  task :upload do
    on roles(:app) do |host|
      upload! '/Users/kawasaki-atsushi/.env', '/var/www/current/'
    end
  end
end
after 'deploy:published', 'deploy:upload'
after 'deploy:finishing', 'deploy:restart'

# デプロイ前に実行する必要がある。
# desc 'execute before deploy'
# task :db_create do
#   on roles(:db) do |host|
#     execute "mysql -uroot -e 'CREATE DATABASE IF NOT EXISTS kayacInternApp_production;'"
#   end
# end

desc 'Create Database'
task :db_create do
  on roles(:db) do |host|
    with rails_env: fetch(:rails_env) do
      within current_path do
        execute :bundle, :exec, :rake, 'db:create'
    end
    end
  end
end
