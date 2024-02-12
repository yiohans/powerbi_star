# Default target
.PHONY: all
all: run

.PHONY: update_submodules
update_submodules:
	git submodule update --remote --merge

.PHONY: setup_directory_permissions
setup_directory_permissions: update_submodules
	@if [ ! -d "spark_airflow/logs" ]; then \
		mkdir  spark_airflow/logs/; \
	fi
	sudo chown 50000:0 spark_airflow/logs/; \
	sudo chmod 755 spark_airflow/logs/; \

.PHONY: build
build: update_submodules
	docker compose build

.PHONY: run
run: update_submodules
	docker compose up -d

.PHONY: stop
stop:
	docker compose stop

.PHONY: down
down:
	docker compose down