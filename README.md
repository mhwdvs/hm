# hm
My nix/home-manager configuration

## What makes this special

- ~~NixOS rebuild script that is accessible system-wide - install and somewhat forget~~

## Usage

### NixOS

#### Install

- Install NixOS
- Build machine config
    - `sudo nixos-rebuild -I nixos-config="machines/<desired machine config directory>/configuration.nix" switch`
- Set password of user `matthew`

#### Rebuild

- `my-nixos-rebuild`



