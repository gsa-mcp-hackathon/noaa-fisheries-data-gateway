# syntax=docker/dockerfile:1
# Pinned multi-stage build for the public snapshot container.

FROM ghcr.io/astral-sh/uv:0.13.9@sha256:d3b601f0c7b118bc1753febf7c41cc80981df678445e0254284eecf84db79a7d AS uv

FROM python:3.15-slim-bookworm@sha256:96599df822d0e1c6bb700014a05c7f3c8cabc6e0f7ff3c4f9f69cee033b4b5d9 AS builder

WORKDIR /app
COPY --from=uv /uv /uvx /bin/
COPY pyproject.toml uv.lock README.md ./
COPY src ./src
RUN uv sync --locked --no-dev --no-editable

FROM python:3.15-slim-bookworm@sha256:96599df822d0e1c6bb700014a05c7f3c8cabc6e0f7ff3c4f9f69cee033b4b5d9

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app/src
ENV PATH="/app/.venv/bin:${PATH}"
ENV PORT=8080

WORKDIR /app
RUN groupadd --system --gid 10001 fisheries \
    && useradd --system --uid 10001 --gid fisheries \
        --no-create-home --shell /usr/sbin/nologin fisheries \
    && mkdir -p data \
    && chmod 0755 data
COPY --from=builder /app/.venv /app/.venv
COPY --chmod=0444 data/spring.sqlite ./data/spring.sqlite

USER 10001:10001
EXPOSE 8080

# PORT selects HTTP, but app startup refuses to bind without an explicit
# MCP_TRUSTED_HTTP_INGRESS=true operator acknowledgement.
CMD ["python", "-m", "fisheries_mcp.app"]
