# Custom sandbox image for coder agent
# Based on Python 3.11 slim with an enriched document/data-processing stack

FROM python:3.11-slim-bookworm

ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install essential tools + document/data utilities.
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    ca-certificates \
    curl \
    file \
    git \
    jq \
    libmagic1 \
    poppler-utils \
    ripgrep \
    sqlite3 \
    tree \
    unzip \
    xz-utils \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Pre-install practical Python packages for coding, HTML parsing, and common document/data workflows.
RUN pip3 install --no-cache-dir \
    aiohttp \
    beautifulsoup4 \
    black \
    chardet \
    flake8 \
    html5lib \
    httpx \
    lxml \
    markdownify \
    mypy \
    numpy \
    odfpy \
    openpyxl \
    pandas \
    pdfplumber \
    pillow \
    pydantic \
    pypdf \
    pytest \
    pytest-asyncio \
    python-docx \
    python-pptx \
    pyxlsb \
    pyyaml \
    reportlab \
    requests \
    tabulate \
    xlrd

# Create workspace and agent state directory.
RUN mkdir -p /workspace/.agent

# Initialize agent state templates (runtime still does idempotent init).
RUN printf '# Agent Memory\n\n## Task Context\n(Updated during execution)\n' > /workspace/.agent/memory.md && \
    printf '# Task Plan\n\n## Steps\n(Generated on task start)\n' > /workspace/.agent/plan.md && \
    printf '# Error Log\n\n## Errors\n(Logged during execution)\n' > /workspace/.agent/errors.md && \
    printf '{"iteration": 0, "current_step": 0, "status": "IDLE", "retry_count": 0}' > /workspace/.agent/state.json

WORKDIR /workspace
CMD ["/bin/bash"]
