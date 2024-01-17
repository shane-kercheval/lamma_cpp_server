docker_build:
	docker compose -f docker-compose.yml build

docker_run: docker_build
	docker compose -f docker-compose.yml up

docker_down:
	docker compose down --remove-orphans

docker_rebuild:
	docker compose -f docker-compose.yml build --no-cache

docker_build_image:
	docker build -t lamma_cpp_server .

docker_run_bash:
	docker run --gpus all -v "./models:/app/models" -it lamma_cpp_server
