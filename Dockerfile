# Builder Stage
FROM golang:1.21 as builder
WORKDIR /app

# Copy go.mod and go.sum first for better layer caching
COPY go.mod go.sum ./
RUN go mod download

# Now copy the rest of the application
COPY . .

# Build the binary
RUN go build -o main .

# Runtime Stage
FROM debian:bookworm-slim
WORKDIR /app

# Copy binary from builder stage
COPY --from=builder /app/main .

# Expose port
EXPOSE 8080

# Start the app
CMD ["./main"]
