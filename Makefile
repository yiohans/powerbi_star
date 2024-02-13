# Default target
.PHONY: all
all: up

.PHONY: update_submodules
update_submodules:
	git submodule update --remote --merge

.PHONY: setup_directory_permissions
setup_directory_permissions:
	@if [ ! -d "spark_airflow/dags" ]; then \
		mkdir  spark_airflow/dags/; \
	fi
	@if [ ! -d "spark_airflow/jobs" ]; then \
		mkdir  spark_airflow/jobs/; \
	fi
	@if [ ! -d "spark_airflow/logs" ]; then \
		mkdir  spark_airflow/logs/; \
	fi
	@if [ ! -d "spark_airflow/exports" ]; then \
		mkdir  spark_airflow/exports/; \
	fi
	sudo chown 50000:0 spark_airflow/logs/ && sudo chmod 755 spark_airflow/logs/; \
	sudo chown -R 50000:0 spark_airflow/exports/ && sudo chmod -R 777 spark_airflow/exports/; \

.PHONY: export_connections
export_connections: setup_directory_permissions
	docker exec airflow-webserver airflow connections export exports/airflow_connections.json

.PHONY: import_connections
import_connections: setup_directory_permissions
	docker exec airflow-webserver airflow connections import exports/airflow_connections.json

.PHONY: build
build: update_submodules setup_directory_permissions
	docker compose build
	$(MAKE) import_connections

.PHONY: up
up: update_submodules setup_directory_permissions
	docker compose up -d
	$(MAKE) import_connections
.PHONY: stop
stop: export_connections
	docker compose stop

.PHONY: down
down: export_connections
	docker compose down

.PHONY: convert_notebooks
convert_notebooks:
	docker exec jupyter nbconvert --to script /*.ipynb