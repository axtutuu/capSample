# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'Myprojects'
set :repo_url, 'git@github.com:kawasakiatsushi/X_Blog.git'
set :deploy_to, '/var/www/'
set :scm, :git
set :keep_releases, 5

# rbenvの設定
set :default_env, {
  rbenv_root: "/home/ec2-user/.rbenv",
  path: "/home/ec2-user/.rbenv/shims:/home/ec2-user/.rbenv/bin:$PATH"
}

# Unicorn周りの設定
set :unicorn_rack_env, "none"
set :unicorn_config_path, "config/unicorn.rb"
set :unicorn_pid, "/tmp/unicorn_Myprojects.pid"

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:legacy_restart'
  end

end
