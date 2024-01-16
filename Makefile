docker_build:
	docker compose -f docker-compose.yml build

docker_run: docker_build
	docker compose -f docker-compose.yml up

docker_down:
	docker compose down --remove-orphans

docker_rebuild:
	docker compose -f docker-compose.yml build --no-cache







# download model
# huggingface-cli download TheBloke/Mistral-7B-v0.1-GGUF mistral-7b-v0.1.Q6_K.gguf --local-dir ./models --local-dir-use-symlinks False

# docker_start_image:
# 	docker run -d --name lamma_cpp_server -v "./models:/app/models" lamma_cpp_server
# 	# docker exec -it lamma_cpp_server ls /app/models

test_api:
	curl -v \
		--url 0.0.0.0:8080/completion \
		--header "Content-Type: application/json" \
		--data '{"prompt": "Building a website can be done in 10 simple steps:","n_predict": 128, "stream": true}'

# curl -v \
#       --url 0.0.0.0:8080/v1/chat/completions \
#       -H "Content-Type: application/json" \
#       -d '{
#       "stream": true,
#       "messages": [
#       {
#             "role": "system",
#             "content": "You are ChatGPT, an AI assistant. Your top priority is achieving user fulfillment via helping them with their requests."
#       },
#       {
#             "role": "user",
#             "content": "Write a limerick about python exceptions"
#       }
#       ]
#       }'

# docker logs my_llama_container

# build/run image from Dockerfile as command line
docker_build_image:
	docker build -t lamma_cpp_server .

docker_run_bash:
	docker run --gpus all -v "./models:/app/models" -it lamma_cpp_server

