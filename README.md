# Distributed Rate Limiter (Go + Redis)

A high-performance rate-limiting service implementing 4 core algorithms.

## Phase 1: Infrastructure
- **Containerization:** Multi-stage Docker build for a minimal footprint (~15MB image).
- **Security:** Runs as a non-privileged `gouser` to mitigate container escape risks.
- **Orchestration:** Docker Compose manages the Go application and a Redis instance.
- **Environment:** Stateless design using Redis for distributed consistency.

## How to Run
1. Ensure Docker and Docker Compose are installed.
2. Run the system:
   ```bash
   docker-compose up --build
   ```