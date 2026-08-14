COMPOSE_PATH	= ./srcs/docker-compose.yml

all: build

build:
	@if [ ! -f ./srcs/.env ]; then \
		cp ./srcs/.env.example ./srcs/.env; \
	fi
	docker compose -f $(COMPOSE_PATH) build

up:
	docker compose -f $(COMPOSE_PATH) up

down:
	docker compose -f $(COMPOSE_PATH) down

# TODO: clean
