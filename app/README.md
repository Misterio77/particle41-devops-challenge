# Simple Time Service

A simple Rust web application, whose single route (/) returns the client's IP and the current time.

## Build

Simply get `cargo` and `rustc` installed, and run:

```
cargo build --release
```

## Usage

You can configure the server with CLI arguments or environment variables, see:

```
./target/release/simple_time_service --help
```
