# syntax=docker/dockerfile:1
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

ENV TZ=Europe/Budapest
RUN echo "tzdata tzdata/Areas select Europe" > debconf-preseed.txt && \
    echo "tzdata tzdata/Zones/Europe select Berlin" >> debconf-preseed.txt && \
    debconf-set-selections debconf-preseed.txt && \
    apt-get update && \
    TZ=Etc/UTC apt-get install -y --no-install-recommends \
        tzdata

##################
# Ubuntu packages
##################
RUN apt update \
    && apt install -y --no-install-recommends \
    apt-utils \
    autoconf \
    automake \
    build-essential \
    bzip2 \
    ca-certificates \
    clang \
    cmake \
    curl \
    ffmpeg \
    git \
    gnupg2 \
    krb5-user \
    libasound2-dev \
    libffi-dev \
    libgl1 \
    libgl1-mesa-dev \
    libglu1-mesa \
    libglu1-mesa-dev \
    libgmp-dev \
    libgtk-3-dev \
    liblzma-dev \
    libpng-dev \
    libsm6 \
    libstdc++-12-dev \
    libxext6 \
    libxrender1 \
    libx11-dev \
    libxmu-dev \
    libxi-dev \
    lshw \
    nano \
    ninja-build \
    openssh-client \
    openssh-server \
    pciutils \
    pkg-config \
    software-properties-common \
    ssh \
    sudo \
    tzdata \
    unzip \
    vim \
    wget \
    xz-utils \
    zip \
    && rm -rf /var/lib/apt/lists/*

########
# Python
########
RUN curl -o ~/miniconda.sh -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x ~/miniconda.sh && \
    ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -ya

ENV PATH /opt/conda/bin:$PATH
RUN conda install -y python=3.13 && conda clean -ya
RUN pip install --upgrade uv && \
    uv pip install --system --upgrade pip setuptools poetry
# Install dependencies
# COPY pyproject.toml uv.lock .
# COPY pyproject.toml .
# RUN uv -vvv pip install --system .
# RUN RUST_LOG=uv=trace uv pip install --system .
# RUN uv pip install --system --upgrade --verbose --no-cache-dir -e .
# RUN cd /opt \
#     && ls \
#     && uv pip install --system .

# RUN uv sync --frozen --no-cache
RUN uv pip install --system --upgrade \
    dm-tree \
    h5py \
    hydra-core \
    ipykernel \
    marimo \
    matplotlib \
    more-itertools \
    numpy \
    pandas \
    plotly \
    pre-commit \
    pyarrow \
    python-dotenv \
    ruff \
    standard-imghdr \
    streamlit \
    streamlit-aggrid \
    tables \
    tabulate \
    toolz \
    ty

######
# npm
######
# Add NodeSource repository for latest Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
# Install Node.js and npm
RUN apt-get install -y nodejs
# Install global npm packages
RUN npm install -g \
    pyright

ARG HOME
ARG USER_NAME
ARG USER_UID
ARG USER_GID
ARG WORKSPACE

RUN echo "Creating group user" && \
    groupadd --gid ${USER_GID} user && \
    echo "Creating user " ${USER_NAME} " with home " ${HOME} && \
    useradd -l -u $USER_UID -s /bin/bash -g user --home-dir ${HOME} -m $USER_NAME  && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER_NAME

WORKDIR $WORKSPACE
