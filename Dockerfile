FROM nvidia/cuda:12.4.1-base-ubuntu22.04 AS build-stage

RUN apt update -y && \
    apt install -y python3.10 \
    bc \
    python3.10-venv \
    pip \
    git \
    google-perftools \
    libgl1 \
    libglib2.0-0 \ 
    wget

WORKDIR /mnt/storage/stable-diffusion-py-docker

COPY . .

RUN wget https://huggingface.co/digiplay/AbsoluteReality_v1.8.1/resolve/main/absolutereality_v181.safetensors -O /mnt/storage/stable-diffusion-py-docker/models/Stable-diffusion/absolutereality_v181.safetensors

RUN wget https://huggingface.co/lokCX/4x-Ultrasharp/resolve/main/4x-UltraSharp.pth -O /mnt/storage/stable-diffusion-py-docker/models/ESRGAN/4x-UltraSharp.pth

RUN wget https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/8x_NMKD-Superscale_150000_G.pth -O /mnt/storage/stable-diffusion-py-docker/models/ESRGAN/8x_NMKD-Superscale_150000_G.pth

# CMD tail -F /dev/null

CMD ["./webui.sh", "--listen", "--port", "7860", "--enable-insecure-extension-access"]

# ./webui.sh --listen --port 7860 --enable-insecure-extension-access

# CMD ["./webui.sh", "--listen", "--port", "7860", "--use-cpu all", "--no-half", "--no-half-vae", "--skip-torch-cuda-test"]
# ./webui.sh --listen --port 7860 --use-cpu all --no-half --no-half-vae --skip-torch-cuda-test --enable-insecure-extension-access

# docker run --gpus all -e NVIDIA_DRIVER_CAPABILITIES=all -e NVIDIA_REQUIRE_CUDA="cuda=12.4" -it -v $(pwd):/app -p 8080:7860 -d stable-diffusion tail -f /dev/null