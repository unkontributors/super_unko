.PHONY: default
default: usage

.PHONY: usage
usage: ## Print help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## Setup docker images
	docker-compose build --parallel
	docker-compose -f docker-compose-ci.yml build --parallel

.PHONY: check
check: test lint ## Run tests and linter

.PHONY: lint
lint: ## Run linter
	./linter.sh all

.PHONY: test
test: ## Run tests
	docker-compose -f docker-compose-ci.yml run --rm ci_sh_5.0

.PHONY: test-bash-version
test-bash-version: ## Run test all bash version
	docker-compose -f docker-compose-ci.yml up

.PHONY: clean
package: ## Build packages
	./package.sh

.PHONY: clean
clean: ## Clean packages
	$(RM) super_unko.tar.gz pkg/*.tmp
