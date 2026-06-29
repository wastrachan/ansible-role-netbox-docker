.DEFAULT_GOAL := help

.PHONY: help
help:  ## Show this help message
	@echo ""
	@echo "ansible-role-netbox-docker Makefile"
	@echo "Usage: make [target]"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"} \
		/^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5); next } \
		/^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2 }' \
		$(MAKEFILE_LIST)
	@echo ""

.docker-build:
	@docker build . -t ansible-netbox-docker

.PHONY: lint
lint: .docker-build ## Lint project with ansible-lint
	@docker run \
	--rm \
	-it \
	--mount type=bind,source=".",target=/app \
	ansible-netbox-docker \
	ansible-lint
