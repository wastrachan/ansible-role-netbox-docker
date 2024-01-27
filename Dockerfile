FROM python:3.12-bookworm
LABEL description="ansible-gfg-lol run container"
ENV PYTHONUNBUFFERED=1 \
    LANG="C.UTF-8" \
    LANGUAGE="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    LC_CTYPE="C.UTF-8"

# Install dependencies
COPY requirements.txt /requirements.txt
COPY requirements.yml /requirements.yml
RUN set -eux; \
    pip install -r /requirements.txt; \
    ansible-galaxy collection install -r /requirements.yml

# Generate app directory
RUN set -eux; \
    mkdir /app
WORKDIR /app

# Generate user for ssh
RUN useradd -m ansible
RUN mkdir -p /home/ansible/.ssh
RUN chown -R ansible:ansible /home/ansible/.ssh
USER ansible
