# piper-http-gpu
Use this to create a docker image that runs the piper http_server on a NVIDIA GPU (a lot faster than CPU)

This is based on my fork of [piper](https://github.com/rhasspy/piper) which uses fastapi for the server

## Docker Hub
https://hub.docker.com/r/notv3nom/piper-http-gpu

This image uses [lessac-high](https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_US/lessac/high/en_US-lessac-high.onnx?download=true) voice
```bash
docker run -d --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 --name piper-http-gpu -p 5000:5000 notv3nom/piper-http-gpu:0.1
```

## Steps:

1. Clone this repository
2. Create a models folder and add your .onnx and .onnx.json
3. Update the model name in Dockerfile
4. Build the image
    ```bash
    docker build --no-cache -t piper-gpu .
    ```

5. Run the image
    ```bash
    docker run -d --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 --name piper-gpu -p 5000:5000 piper-gpu
    ```
