{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    awscli2
    jq
    opentofu
    kubectl
  ];
}
