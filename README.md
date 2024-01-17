# lamma_cpp_server

Containers `Dockerfile`` and `docker-compose.yml` needed to run `llama.cpp`'s server component. https://github.com/ggerganov/llama.cpp/tree/master/examples/server.

---

# Instructions

Download a `gguf` file into the `models` directory of this project.

For example, from the project directory, run this command (requires `huggingface-hub` package):

```
huggingface-cli download TheBloke/Mistral-7B-Instruct-v0.2-GGUF mistral-7b-instruct-v0.2.Q6_K.gguf --local-dir ./models --local-dir-use-symlinks False
```

Update the `docker-compose.yml` file to set the model in the `command` section. For example:

```
-m models/mistral-7b-instruct-v0.2.Q6_K.gguf
```

Update the Dockerfile with the relevant cuda version, for example:

```
ARG CUDA_VERSION=12.1.1
```

Build and run the docker container with `make docker_run`.

Test the service with, for example:

```
curl -v \
    --url 0.0.0.0:8080/completion \
    --header "Content-Type: application/json" \
    --data '{"prompt": "Building a website can be done in 10 simple steps:","n_predict": 128, "stream": true}'
```

or 

```
curl -v \
    --url 0.0.0.0:8080/v1/chat/completions \
    -H "Content-Type: application/json" \
    -d '{
    "stream": true,
    "messages": [
    {
        "role": "system",
        "content": "You are ChatGPT, an AI assistant. Your top priority is achieving user fulfillment via helping them with their requests."
    },
    {
        "role": "user",
        "content": "Write a limerick about python exceptions"
    }
    ]
    }'
```
---

