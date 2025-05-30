# Builder Stage
FROM golang:1.21 as builder
WORKDIR /app
COPY . .
RUN go mod init application && go build -o main

# Runtime Stage
FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]
