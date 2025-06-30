FROM nvidia/cuda:12.4.1-base-ubuntu22.04 AS build-stage

RUN apt update -y && \
    apt install -y python3.10 \
    bc \
    python3.10-venv \
    pip \
    git \
    google-perftools \
    libgl1 \
    libglib2.0-0

WORKDIR /app

CMD tail -F /dev/null
# CMD ["./webui.sh", "--listen", "--port", "7860", "--use-cpu all", "--no-half", "--no-half-vae", "--skip-torch-cuda-test"]