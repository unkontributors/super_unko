.PHONY: default
default: usage

.PHONY: usage
usage:
	@ echo 'Usage: $(MAKE) TARGET ...'
	@ echo
	@ echo 'Targets:'
	@ echo '  check		Run tests and linter'
	@ echo '  test		Run tests'
	@ echo '  lint		Run linter'
	@ echo '  package	Build packages'

.PHONY: check
check: test lint

.PHONY: lint
lint:
	./linter.sh all

.PHONY: test package
test package:
	./$@.sh

.PHONY: clean
clean:
	$(RM) super_unko.tar.gz pkg/*.tmp

.PHONY: build-containers
build-containers:
	docker-compose build --parallel
	docker-compose -f docker-compose-ci.yml build --parallel

.PHONY: test
test:
	docker-compose -f docker-compose-ci.yml up
