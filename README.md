# Particle41 DevOps Challenge

Hi! This is my solution for the challenge.

## Overview

This repository includes three directories:
- `app`: code for the sample simpletimeservice app. Written in Rust + Axum.
    - Includes `Dockerfile` and k8s `manifest.yml`
    - [README](./app/README.md).
    - TLDR:
        - `cargo run` for local dev
        - `docker build .` for docker container
        - `kubectl apply -f manifest.yml` for k8s deployment
- `terraform`: terraform code for deploying VPC + EKS.
    - [README](./terraform/README.md).
    - TLDR: `./state_init.sh my-cool-state-s3 && terraform apply`

## Things done

### Task 1

Functional reqs:

- [x] Microservice in my language of choice
    - [x] Returns a JSON response (ip and timestamp)
- [x] Make a Dockerfile for it
    - [x] Run app as non-root
    - [x] Publish to a public registry
        - [`docker.io/misterio77/simple_time_service`](https://hub.docker.com/r/misterio77/simple_time_service)
- [x] Create a k8s manifest, containing a Deployment and a Service.
    - [x] Must use your public Docker image from DockerHub.
    - [x] DO NOT use `LoadBalancer` as the service type!
- [x] Push your code to a public git repository
    - [x] No secrets committed :P

Non function reqs:

- [x] Documentation
- [x] Code quality and style
    - Hope it's okay :)
- [x] Small container image
    - Compressed size is `4.31MB` (uncompressed `10.5MB`), as reported by DockerHub

### Task 2

Functional reqs:

- [x] Terraform infrastructure
    - [x] A VPC w/ 2 public and 2 private subnets.
    - [x] EKS cluster deployed to that VPC.
    - [x] 2 nodes
    - [ ] Using instance type `m6a.large`.
        - I don't think m6a.large is required for such a lightweight service in
        a non-prod env. I set the default `instance_types` to `["t2.small"]`.
        Should be exposed as a variable, so feel free to change it.
    - [x] The nodes must be on the private subnets only.
- [x] Push your code to a public git repository
    - [x] No secrets committed :)

Non functional reqs:

- [x] Code quality and style
    - Again, hope you like it :D
- [ ] Use variables in your infrastructure root module and provide some good defaults in a `terraform.tfvars` file.
    - TODO
    - I prefer to provide the defaults together with the variable definitions.

### Extra

- [ ] TF code to actually deploy the 'simpletimeservice' container image to EKS.
    - TODO
- [ ] TF code to use the Helm provider and any public helm chart.
- [ ] Updates to the Kubernetes manifest to utilize best practices
    - TODO
- [ ] A sidecar container of some kind, such as fluentbit.
    - TODO
- [x] Code to initialize and use a remote Terraform backend.
    - See [`state_init.sh`](./terraform/state_init.sh) :)
- [x] Create a simple CI/CD pipeline to publish your image.
    - See [`build-docker-image.yml`](./.github/workflows/build-docker-image.yml)
- [ ] Anything else that might demonstrate that you know what's up.
