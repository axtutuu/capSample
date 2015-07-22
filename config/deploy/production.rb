set :rails_env, :production
server '52.69.9.91',
  user: 'ec2-user',
  roles: %w{web app db},
  ssh_options: {
    user: 'ec2-user', # overrides user setting above
    keys: %w(~/pem/sampleItamae.pem),
    forward_agent: true,
    auth_methods: %w(publickey)
    # password: 'please use keys'
  }
# setting per server overrides global ssh_options
