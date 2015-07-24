set :rails_env, :production
role :app, ["web01", "web02"]
role :web, ["web01", "web02"]
role :db, "db"
