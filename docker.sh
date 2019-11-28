docker build -t explorer .
docker run --env-file=env.list -d --name explorer --network=host explorer mix phx.server