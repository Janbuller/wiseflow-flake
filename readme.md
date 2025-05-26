# Wiseflow Device Monitor for NixOS

An (unofficial) Nix flake that packages the Wiseflow Device Monitor application for NixOS systems.

## Prerequisites

- NixOS or Nix package manager with flakes enabled
- The Wiseflow Device Monitor `.deb` file (must be downloaded manually)

## Installation

### 1. Obtain the Wiseflow Device Monitor Package

Download the official `.deb` package from [Wiseflow's website](https://europe.wiseflow.net/account/invigilation) and place it in your Nix store:

```bash
nix-store --add-fixed sha256 wiseflow_device_monitor_2.4.3_linux.deb
```

### 2. Install

In your systems `flake.nix`:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    wiseflow-flake.url = "github:Janbuller/wiseflow-flake";
  };

  outputs = { self, nixpkgs, wiseflow-flake }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        {
          environment.systemPackages = [
            wiseflow-flake.packages.x86_64-linux.wiseflow-device-monitor
          ];
        }
      ];
    };
  };
}
```

### 3. Set as default handler for WFDM URIs

After installing, run the following command

```sh
xdg-mime default wiseflow-device-monitor.desktop wfdm
```

## License

This packaging is licensed under the MIT License. The Wiseflow Device Monitor software itself is proprietary and subject to Wiseflow's licensing terms.

