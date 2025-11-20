import Config

config :library_app, LibraryApp.Repo,
  database: "library_app_dev",
  username: "postgres",
  password: "sliman",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :library_app, ecto_repos: [LibraryApp.Repo]
