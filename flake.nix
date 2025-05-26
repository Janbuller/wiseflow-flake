{
  description = "Wiseflow Device Monitor derivation for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in rec
      {
        packages = rec {
          default = wiseflow-device-monitor;
          wiseflow-device-monitor = pkgs.callPackage ./wiseflow.nix {};
          grim-gnome-screenshot = pkgs.callPackage ./grim-gnome-screenshot.nix {};
          wiseflow-device-monitor-using-grim = (wiseflow-device-monitor.override {
            gnomeScreenshotProvider = grim-gnome-screenshot;
          });
        };

        apps = {
          default = {
            type = "app";
            program = "${packages.wiseflow-device-monitor}/bin/wiseflow-device-monitor";
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [ packages.wiseflow-device-monitor ];
        };
      });
}
