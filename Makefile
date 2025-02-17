# Makefile for preparing host directories and running Docker Compose

# Use the current user's home directory and name from env vars.
HOME_DIR ?= $(HOME)
USER_NAME ?= $(USER)

# Base host data directory; adjust if you prefer a different path.
DATA_DIR := $(HOME_DIR)/data

# Host directories for the bind mounts.
WP_DATA_DIR := $(DATA_DIR)/wordpress_data
DB_DATA_DIR := $(DATA_DIR)/mariadb_data

# Scrs dir for running docker commands etc
SCRS_DIR := scrs

# Container UID/GID expectations.
# For WordPress (e.g., www-data). Adjust these if your image uses different IDs.
WP_UID := 33
WP_GID := 33

# For MariaDB (e.g., mysql). Adjust as needed.
DB_UID := 101
DB_GID := 101

.PHONY: dirs up down

# Create directories (if not present) and set permissions.
dirs:
	@echo "Creating host directories for volumes..."
	mkdir -p $(WP_DATA_DIR)
	mkdir -p $(DB_DATA_DIR)
	@echo "Setting permissions for WordPress data directory..."
	sudo chown -R $(WP_UID):$(WP_GID) $(WP_DATA_DIR)
	sudo chmod -R 755 $(WP_DATA_DIR)
	@echo "Setting permissions for MariaDB data directory..."
	sudo chown -R $(DB_UID):$(DB_GID) $(DB_DATA_DIR)
	sudo chmod -R 750 $(DB_DATA_DIR)

# Build the containers (if needed) and start them.
up: dirs
	@echo "Starting containers with docker-compose..."
	cd $(SCRS_DIR) && docker compose up -d

# Bring the containers down.
down:
	@echo "Shutting down containers..."
	cd $(SCRS_DIR) && docker compose down

clean:
	cd $(SCRS_DIR) && docker compose down -v --rmi all

fclean: clean
	sudo rm -rf $(DATA_DIR)
