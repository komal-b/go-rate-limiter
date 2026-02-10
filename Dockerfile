# --- STAGE 1: The Builder ---
# This stage has all the Go tools to compile the code
FROM golang:1.22-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the dependency files first (optimizes Docker layer caching)
COPY go.mod ./

# COPY go.sum ./

# Download dependencies
RUN go mod download

# Copy the rest of the source code
COPY . .

# Compile the app into a binary named "limiter"
# CGO_ENABLED=0 makes it a static binary that doesn't need external libraries
RUN CGO_ENABLED=0 GOOS=linux go build -o /limiter ./cmd/server/main.go

# --- STAGE 2: The Runner ---
# Use a tiny, secure base image for production
FROM alpine:latest

# Security: Don't run as root
RUN adduser -D gouser
USER gouser

WORKDIR /

# Copy only the compiled binary from the builder stage
COPY --from=builder --chown=gouser:gouser /limiter /limiter

# The port our service will listen on
EXPOSE 8080

# Run the app
ENTRYPOINT ["/limiter"]