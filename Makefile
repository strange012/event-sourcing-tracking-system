compose:
	docker compose up web
compose-install:
	docker compose run --rm --no-deps web bundle
compose-bash:
	docker compose run --use-aliases --rm web bash -c "bundle && bash"
compose-console:
	docker compose run --use-aliases --rm web bash -c "bundle && rails c"
compose-rubocop:
	docker compose run --use-aliases --rm web bash -c "bundle exec rubocop"
