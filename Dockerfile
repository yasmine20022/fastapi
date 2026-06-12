FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends build-essential git libffi-dev libpq-dev libssl-dev python3-dev && rm -rf /var/lib/apt/lists/*
RUN touch README.md
COPY . ./
RUN pip install --no-cache-dir . || pip install --no-cache-dir .
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl --fail http://localhost:8000/ || exit 1
RUN groupadd -r app && useradd -r -g app app
USER app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]