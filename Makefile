#
# Ansible role to configure Netbox as a docker-compose project
#
# Copyright (c) 2024 Winston Astrachan
#
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
	ansible-lint
