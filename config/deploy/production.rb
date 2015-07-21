set :rails_env, :production
# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.

# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
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
