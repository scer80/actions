export WORKSPACE=$(shell pwd)
export USER_NAME=$(shell whoami)
export USER_UID=$(shell id -u)
export USER_GID=$(shell id -g)
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

export PROJECT_NAME=actions
export DEV_SERVICE=dev-$(USER_NAME)
export DOCKER_COMPOSE_BASE_FILE=docker/$(PROJECT_NAME).docker-compose.yml
export DOCKER_COMPOSE_USER_FILE=docker/$(PROJECT_NAME).docker-compose-$(USER_NAME).yml
export DOCKER_COMPOSE_CMD=docker compose --project-name $(PROJECT_NAME) --file $(DOCKER_COMPOSE_USER_FILE)


update-yml:
	sed "s/  dev:/  dev-${USER_NAME}:/" $(DOCKER_COMPOSE_BASE_FILE) > $(DOCKER_COMPOSE_USER_FILE)

build: update-yml
	cp $(REQUESTS_CA_BUNDLE) docker/
	$(DOCKER_COMPOSE_CMD) \
		--progress plain \
		build
	rm docker/ca-certificates.crt

shell: update-yml
	$(DOCKER_COMPOSE_CMD) up -d $(DEV_SERVICE) \
	&& $(DOCKER_COMPOSE_CMD) exec $(DEV_SERVICE) /bin/bash

stop: update-yml
	$(DOCKER_COMPOSE_CMD) down
