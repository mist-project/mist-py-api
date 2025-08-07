# ---- Base stage ----
FROM python:3.12.8-slim AS base

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    UV_CACHE_DIR=/root/.cache/uv

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl gcc && rm -rf /var/lib/apt/lists/*

# Install uv and ensure it's on PATH
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:${PATH}"

# ---- Dependencies stage ----
FROM base AS deps

# Copy project metadata only (for lock + sync)
COPY pyproject.toml ./
# If you have a lockfile, include it too:
# COPY uv.lock ./

# Create a venv with runtime deps only
RUN uv sync --no-dev

# ---- Final stage ----
FROM base AS final

# Bring in the resolved virtualenv
COPY --from=deps /app/.venv /app/.venv

# App env + venv PATH
ENV PATH="/app/.venv/bin:${PATH}" \
    APP_PORT=4001

# Copy source
COPY src/ ./src

# Keep workdir at /app; invoke manage.py via path
WORKDIR /app

EXPOSE 4001
# Use shell so ${APP_PORT} expands; bind to 0.0.0.0
CMD sh -c "python src/manage.py runserver 0.0.0.0:${APP_PORT}"
