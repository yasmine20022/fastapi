FROM python:3.11-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends libldap2-dev libsasl2-dev libcurl4-openssl-dev build-essential git libffi-dev libpq-dev libssl-dev python3-dev && rm -rf /var/lib/apt/lists/*
RUN touch README.md
COPY . ./
RUN pip install --no-cache-dir . || pip install --no-cache-dir . || pip install --no-cache-dir -e .
COPY . /app/
EXPOSE 8000
HEALTHCHECK CMD curl --fail http://localhost:8000/ || exit 1
USER 1001
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
