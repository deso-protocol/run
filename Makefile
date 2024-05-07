devnet:
	docker compose -p devnet -f devnet.docker-compose.yml build && docker compose -f devnet.docker-compose.yml up

devnet-wipe:
	docker compose -p devnet -f devnet.docker-compose.yml down --volumes

testnet:
	docker compose -f testnet.docker-compose.yml build && docker compose -f testnet.docker-compose.yml up

testnet-wipe:
	docker compose -f testnet.docker-compose.yml down --volumes

mainnet:
	docker compose -p mainnet -f mainnet.docker-compose.yml build && docker compose -f mainnet.docker-compose.yml up

mainnet-wipe:
	docker compose -p mainnet -f mainnet.docker-compose.yml down --volumes

local:
	(cd ../ && docker buildx build -f ./backend/Dockerfile -t local-backend:latest . )
	docker compose -p local -f local.docker-compose.yml build && docker compose -f local.docker-compose.yml up

local-wipe:
	docker compose -p local -f local.docker-compose.yml down --volumes

wipe:
	make local-wipe
	make devnet-wipe
	make testnet-wipe
	make mainnet-wipe
