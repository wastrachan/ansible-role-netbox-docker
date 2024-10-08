FROM python:3.13-bookworm

LABEL org.opencontainers.image.title="Ansible Runner"
LABEL org.opencontainers.image.description="Ansible Run Container"
LABEL org.opencontainers.image.licenses="MIT"

ENV PYTHONUNBUFFERED=1 \
    LANG="C.UTF-8" \
    LANGUAGE="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    LC_CTYPE="C.UTF-8"

# Generate app directory
RUN set -eux; \
    mkdir /app
WORKDIR /app

# Install dependencies
COPY requirements.txt /requirements.txt
COPY requirements.yml /requirements.yml
RUN set -eux; \
    pip install -r /requirements.txt; \
    ansible-galaxy collection install -r /requirements.yml
