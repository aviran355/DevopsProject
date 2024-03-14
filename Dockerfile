# Stage 1: Build stage
FROM python:3.9-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Stage 2: Final stage
FROM python:3.9-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY app.py .
# Ensure scripts in .local are usable:
ENV PATH=/root/.local/bin:$PATH
CMD ["python", "app.py"]