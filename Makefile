SHELL=/bin/bash

.PHONY: help
help:
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  lint              Lint project with ansible-lint"
	@echo ""

.docker-build:
	@docker build . -t ansible-netbox-docker

.PHONY: lint
lint: .docker-build
	@docker run \
	--rm \
	-it \
	--mount type=bind,source=".",target=/app \
	ansible-netbox-docker \
	ansible-lint
