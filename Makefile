compose:
	docker compose up web
compose-build:
	docker compose build web
compose-install:
	docker compose run --rm --no-deps web bundle
compose-rspec:
	docker compose run --rm -e RAILS_ENV=test web rspec
compose-bash:
	docker compose run web bash -c "bundle && bash"
compose-console:
	docker compose run web bash -c "bundle && rails c"
compose-rubocop:
	docker compose run --rm web bash -c "bundle exec rubocop"
compose-test-setup:
	docker compose run --rm -e RAILS_ENV=test web bash -c "rails db:create db:migrate"
