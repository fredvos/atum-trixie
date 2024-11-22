DOCKER_USERNAME ?= mokolo-org
APPLICATION_NAME ?= atum
TIMESTAMP ?= $(shell date +"%Y%m%d-%H%M%S")

build:
	docker build --no-cache --tag ${DOCKER_USERNAME}/${APPLICATION_NAME}:$(TIMESTAMP) .
	docker tag ${DOCKER_USERNAME}/${APPLICATION_NAME}:$(TIMESTAMP) ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest
	for tag in $(shell docker run --rm -i -t ${DOCKER_USERNAME}/${APPLICATION_NAME}:$(TIMESTAMP) '/usr/local/bin/get-tags') ; do \
		docker tag ${DOCKER_USERNAME}/${APPLICATION_NAME}:$(TIMESTAMP) ${DOCKER_USERNAME}/${APPLICATION_NAME}:$$tag ; \
	done
