# Multi-stage build, so that the final image does not have the heavy-weight
# rust toolchain

# Build step
FROM rust:alpine3.19 as builder
WORKDIR /app
RUN apk add --no-cache musl-dev
COPY . .
RUN cargo build --release


# Run step
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/target/release/simple_time_service .

# Drop privileges
USER nobody
ENV STS_PORT=8080
EXPOSE 8080

ENTRYPOINT ["/app/simple_time_service"]
