FROM mcr.microsoft.com/devcontainers/base:trixie

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        make \
        python3 \
        python3-venv \
        nodejs \
        npm \
    && rm -rf /var/lib/apt/lists/* \
    && git config --system --add safe.directory '*'

COPY requirements.txt /tmp/requirements.txt

RUN python3 -m venv /opt/venv \
    && /opt/venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt \
    && chown -R vscode:vscode /opt/venv

ENV PATH="/opt/venv/bin:${PATH}"
