COMPOSE_PATH	= ./srcs/docker-compose.yml

all: build

build:
	docker compose -f $(COMPOSE_PATH) build

up:
	docker compose -f $(COMPOSE_PATH) up

down:
	docker compose -f $(COMPOSE_PATH) down

# TODO: clean
