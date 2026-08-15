COMPOSE_PATH	= ./srcs/docker-compose.yml
DATA_PATH		= /home/dnantet/Documents/Inception/data

all: build

build:
	@if [ ! -f ./srcs/.env ]; then \
		cp ./srcs/.env.example ./srcs/.env; \
	fi
	mkdir -p $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress $(DATA_PATH)/nginx
	docker compose -f $(COMPOSE_PATH) build

up:
	docker compose -f $(COMPOSE_PATH) up

down:
	docker compose -f $(COMPOSE_PATH) down

# TODO: clean

.PHONY: all build up down