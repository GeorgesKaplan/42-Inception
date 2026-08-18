COMPOSE_PATH	= ./srcs/docker-compose.yml
DATA_PATH		= /home/dnantet/data

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

ps:
	cd srcs/ && docker compose ps

clean:
	docker stop $(docker ps -qa); \
	docker rm $(docker ps -qa); \
	docker rmi -f $(docker images -qa); \
	docker volume rm $(docker volume ls -q); \
	docker network rm $(docker network ls -q) 2>/dev/null

.PHONY: all build up down ps clean