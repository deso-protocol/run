COMPOSE_FILES := devnet.docker-compose.yml testnet.docker-compose.yml mainnet.docker-compose.yml local.docker-compose.yml

define compose_up
	docker compose -p $(1) -f $(1).docker-compose.yml build
	docker compose -p $(1) -f $(1).docker-compose.yml up
endef

define compose_down
	docker compose -p $(1) -f $(1).docker-compose.yml down --volumes
endef

define wipe_volumes
	@volumes=$$(docker volume ls -qf "name=$(1)") && \
	for volume in $$volumes; do \
		containers=$$(docker ps -a -q --filter "volume=$$volume"); \
		for container in $$containers; do \
			docker stop $$container; \
			docker rm $$container; \
		done; \
		docker volume rm $$volume; \
	done
endef

define clear_containers
	@containers=$$(docker ps -a -q -f "name=$(1)") && \
	for container in $$containers; do \
		docker stop $$container; \
		docker rm $$container; \
	done
endef

define stop_backend
	@if docker ps -a --format '{{.Names}}' | grep -q "backend"; then \
		docker stop backend; \
		docker rm backend; \
	fi
endef

define stop_frontend
	@if docker ps -a --format '{{.Names}}' | grep -q "frontend"; then \
		docker stop frontend; \
		docker rm frontend; \
	fi
endef

define stop_nginx
	@if docker ps -a --format '{{.Names}}' | grep -q "nginx"; then \
		docker stop nginx; \
		docker rm nginx; \
	fi
endef

.PHONY: devnet testnet mainnet local wipe

devnet testnet mainnet local:
	$(call compose_up,$@)

devnet-wipe testnet-wipe mainnet-wipe local-wipe:
	$(call compose_down,$(subst -wipe,,$@))
	$(call clear_containers,$(subst -wipe,,$@))
	$(call wipe_volumes,$(subst -wipe,,$@))
	$(call stop_backend)
	$(call stop_frontend)
	$(call stop_nginx)

local:
	(cd ../ && docker buildx build -f ./backend/Dockerfile -t local-backend:latest .)
	$(call compose_up,$@)

wipe: local-wipe devnet-wipe testnet-wipe mainnet-wipe
