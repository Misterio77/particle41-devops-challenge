{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  packages = [pkgs.awscli2 pkgs.jq pkgs.opentofu];
}
