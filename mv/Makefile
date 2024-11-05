


# Command to build and start containers
up:
	docker-compose -f srcs/docker-compose.yml  up --build -d

# Command to stop containers
down:
	docker-compose -f srcs/docker-compose.yml  down

# Command to view logs of all containers
logs:
	docker-compose -f srcs/docker-compose.yml  logs -f

# Command to clean up all stopped containers and volumes
clean:
	docker-compose -f srcs/docker-compose.yml down -v
	docker volume prune -f

# Command to rebuild images without using cache
rebuild:
	docker-compose -f srcs/docker-compose.yml build --no-cache

.PHONY: up down logs clean rebuild
