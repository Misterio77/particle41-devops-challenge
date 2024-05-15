FROM rust:alpine3.19 as builder
WORKDIR /app
RUN apk add --no-cache musl-dev
COPY . .
RUN cargo build --release

FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/target/release/simple_time_service .
ENV STS_PORT=8080
EXPOSE 8080
ENTRYPOINT ["/app/simple_time_service"]
