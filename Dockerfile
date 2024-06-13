	# Use Nvidia CUDA base image
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04 as base

# Prevents prompts from packages asking for user input during installation
ENV DEBIAN_FRONTEND=noninteractive
# Prefer binary wheels over source distributions for faster pip installations
ENV PIP_PREFER_BINARY=1
# Ensures output from python is printed immediately to the terminal without buffering
ENV PYTHONUNBUFFERED=1 

# Install Python, git and other necessary tools
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
    wget

# Clean up to reduce image size
RUN apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Clone ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /comfyui

# Change working directory to ComfyUI
WORKDIR /comfyui

# Install ComfyUI dependencies
RUN pip3 install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cu121
RUN pip3 install --no-cache-dir torchvision --index-url https://download.pytorch.org/whl/cu121
RUN pip3 install --no-cache-dir torchaudio --index-url https://download.pytorch.org/whl/cu121
RUN pip3 install --no-cache-dir xformers==0.0.21
RUN pip3 install -r requirements.txt

# Clone the repositories
# Clone the necessary repositories
RUN git clone  https://github.com/bennykok/comfyui-deploy.git custom_nodes/comfyui-deploy && \
    cd custom_nodes/comfyui-deploy && git checkout 9b24b120061058c5b05f2d72f0aa1e49ee0ecb1d

RUN git clone  https://github.com/cubiq/ComfyUI_IPAdapter_plus.git custom_nodes/comfyUI_IPAdapter_plus && \
    cd custom_nodes/comfyUI_IPAdapter_plus && git checkout 6a411dcb2c6c3b91a3aac97adfb080a77ade7d38

RUN git clone  https://github.com/Fannovel16/comfyui_controlnet_aux.git custom_nodes/comfyui_controlnet_aux && \
    cd custom_nodes/comfyui_controlnet_aux && git checkout c0b33402d9cfdc01c4e0984c26e5aadfae948e05

RUN git clone  https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git custom_nodes/comfyUI-VideoHelperSuite && \
    cd custom_nodes/comfyUI-VideoHelperSuite && git checkout 47e56f3e42c3ab4fb33f1407c2c40b5391226621

RUN git clone  https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git custom_nodes/comfyUI-Advanced-ControlNet && \
    cd custom_nodes/comfyUI-Advanced-ControlNet && git checkout 33d9884b76e8d7a2024691c5d98308e7e61bf38d

RUN git clone  https://github.com/jags111/efficiency-nodes-comfyui.git /app/efficiency-nodes-comfyui && \
    cd /app/efficiency-nodes-comfyui && git checkout 3b7e89d969c02b80ff3662f34813679167b835fa

RUN git clone  https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git custom_nodes/comfyUI_UltimateSDUpscale && \
    cd custom_nodes/comfyUI_UltimateSDUpscale && git checkout b303386bd363df16ad6706a13b3b47a1c2a1ea49

RUN git clone  https://github.com/cubiq/ComfyUI_essentials.git custom_nodes/comfyUI_essentials && \
    cd custom_nodes/comfyUI_essentials && git checkout 1a1b4bf5c4a73e85d5d0cd9ab5e8c2d26eaf6232

RUN git clone  https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git custom_nodes/comfyUI-Custom-Scripts && \
    cd custom_nodes/comfyUI-Custom-Scripts && git checkout 3f2c021e50be2fed3c9d1552ee8dcaae06ad1fe5

RUN git clone  https://github.com/WASasquatch/was-node-suite-comfyui.git /app/was-node-suite-comfyui && \
    cd /app/was-node-suite-comfyui && git checkout 6c3fed70655b737dc9b59da1cadb3c373c08d8ed

RUN git clone  https://github.com/gokayfem/ComfyUI-Texture-Simple.git custom_nodes/comfyUI-Texture-Simple && \
    cd custom_nodes/comfyUI-Texture-Simple && git checkout 98608f8d866376f5330e63b04b0aebf594288041

RUN git clone  https://github.com/palant/extended-saveimage-comfyui.git /app/extended-saveimage-comfyui && \
    cd /app/extended-saveimage-comfyui && git checkout 588fa79aec290b78ce419b23756ed9e1ccff46fb

RUN git clone  https://github.com/pythongosssss/ComfyUI-WD14-Tagger.git custom_nodes/comfyUI-WD14-Tagger && \
    cd custom_nodes/comfyUI-WD14-Tagger && git checkout d2d482868364f942ace65d49630d017ec13ee47e

RUN git clone  https://github.com/theUpsider/ComfyUI-Logic.git custom_nodes/comfyUI-Logic && \
    cd custom_nodes/comfyUI-Logic && git checkout fb8897351f715ea75eebf52e74515b6d07c693b8

RUN git clone  https://github.com/Acly/comfyui-tooling-nodes.git custom_nodes/comfyui-tooling-nodes && \
    cd custom_nodes/comfyui-tooling-nodes && git checkout 96dd277b533d71cdfdc5f01b98899045315b56e7

RUN git clone  https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved.git custom_nodes/comfyUI-AnimateDiff-Evolved && \
    cd custom_nodes/comfyUI-AnimateDiff-Evolved && git checkout eba6a50ea41468dd0a6a84ca53d0487ac1d765c4

RUN git clone  https://github.com/FizzleDorf/ComfyUI_FizzNodes.git custom_nodes/comfyUI_FizzNodes && \
    cd custom_nodes/comfyUI_FizzNodes && git checkout 51a29ce041f504583efdd3b9488ee6144dfda7de

RUN git clone  https://github.com/TinyTerra/ComfyUI_tinyterraNodes.git custom_nodes/comfyUI_tinyterraNodes && \
    cd custom_nodes/comfyUI_tinyterraNodes && git checkout 7ef66f1791d2506f083e737469b05dbe8f2fd991

RUN git clone  https://github.com/shiimizu/ComfyUI-PhotoMaker-Plus.git custom_nodes/comfyUI-PhotoMaker-Plus && \
    cd custom_nodes/comfyUI-PhotoMaker-Plus && git checkout 4c6108486de52e392b4d25620f63f0413f3e1a55

RUN git clone  https://github.com/BadCafeCode/masquerade-nodes-comfyui.git /app/masquerade-nodes-comfyui && \
    cd /app/masquerade-nodes-comfyui && git checkout 69a944969c29d1c63dfd62eb70a764bceb49473d

RUN git clone  https://github.com/Gourieff/comfyui-reactor-node.git custom_nodes/comfyui-reactor-node && \
    cd custom_nodes/comfyui-reactor-node && git checkout 467b50614e00002a9922141c33103a5ffec92d67

RUN git clone  https://github.com/cubiq/ComfyUI_InstantID.git custom_nodes/comfyUI_InstantID && \
    cd custom_nodes/comfyUI_InstantID && git checkout d8c70a0cd8ce0d4d62e78653674320c9c3084ec1

RUN git clone  https://github.com/ZHO-ZHO-ZHO/ComfyUI-BRIA_AI-RMBG.git custom_nodes/comfyUI-BRIA_AI-RMBG && \
    cd custom_nodes/comfyUI-BRIA_AI-RMBG && git checkout 827fcd63ff0cfa7fbc544b8d2f4c1e3f3012742d

RUN git clone  https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git custom_nodes/comfyUI_Comfyroll_CustomNodes && \
    cd custom_nodes/comfyUI_Comfyroll_CustomNodes && git checkout d78b780ae43fcf8c6b7c6505e6ffb4584281ceca


#ARG SKIP_DEFAULT_MODELS
# Download checkpoints/vae/LoRA to include in image.
#RUN if [ -z "$SKIP_DEFAULT_MODELS" ]; then wget -O models/checkpoints/sd_xl_base_1.0.safetensors https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors; fi
#RUN if [ -z "$SKIP_DEFAULT_MODELS" ]; then wget -O models/vae/sdxl_vae.safetensors https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors; fi
#RUN if [ -z "$SKIP_DEFAULT_MODELS" ]; then wget -O models/vae/sdxl-vae-fp16-fix.safetensors https://huggingface.co/madebyollin/sdxl-vae-fp16-fix/resolve/main/sdxl_vae.safetensors; fi

# Install Python dependencies
RUN pip install --no-cache-dir insightface numba ultralytics 

# Install runpod
RUN pip3 install runpod requests

RUN pip install --no-cache-dir aiofiles numexpr

RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libxrender1 \
    libxext6 \
    libfreetype6 \
    libfontconfig1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Support for the network volume
ADD src/extra_model_paths.yaml ./

# Go back to the root
WORKDIR /

# Add the start and the handler
ADD src/start.sh src/rp_handler.py test_input.json ./
RUN chmod +x /start.sh

# Start the container
CMD /start.sh
