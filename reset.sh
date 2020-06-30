export DATABASE_URL=postgresql://postgres:nexty@localhost:5432/explorer
mix do ecto.drop, ecto.create, ecto.migrate
./explorer.sh