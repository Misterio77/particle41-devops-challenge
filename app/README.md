# Simple Time Service

A simple Rust web application, whose single route (/) returns the client's IP and the current time.

## Dependencies

For local dev, you need `cargo` and `rustc`. See your distro docs on how to get that.

If you're into Nix, I have provided a `shell.nix` to get you up and running quickly. Run:

```
nix-shell
```

## Build

```
cargo run --release
```

### Docker

```
docker build . -t simple_time_service
docker run -p 8080:8080 simple_time_service
```

Pre-built image is available on DockerHub:

```
docker pull docker.io/misterio77/simple_time_service
```

## Usage/configuration

You can configure the server with CLI arguments or environment variables, see `--help`:

```
simple_time_service --help
```

### Kubernetes

Includes a simple `manifest.yml` for kubernetes usage. See [`../terraform/README.md`](../terraform/README.md) for steps on how to use EKS with it.

Simply run:

```
kubectl apply -f manifest.yml
```

Do note this uses the docker image uploaded at DockerHub. So adjust it accordingly.
