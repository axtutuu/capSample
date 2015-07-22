set :rails_env, :production
server '192.168.33.10',
  user: 'vagrant',
  roles: %w{web app db},
  ssh_options: {
    forward_agent: true,
    auth_methods: %w(publickey)
    # password: 'please use keys'
  }
# setting per server overrides global ssh_options
