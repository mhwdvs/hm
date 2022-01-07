# hm

My NixOS/home-manager configuration (with great inspiration taken from [Opeik's Nix/NixOS/home-manager config](https://github.com/opeik/nix))

## What's special

- Wrapped `nixos-rebuild` and `nixos-upgrade` scripts for each profile (eg `P50-personal-nixos-rebuild`) that is automatically made accessible system-wide
    - Can switch configurations without having to navigate to this repo or remember the non-trivial `sudo nixos-rebuild switch --flake <directory>/.#<profile>` command in 6 months time
- `nvidia-offload` script for hybrid graphics on my Lenovo P50 (your mileage may vary on other laptops) that allows you to offload specific graphically-intense processes to the dedicated GPU, or not and use integrated graphics for better power efficiency. AFAIK there is no better solution for hybrid graphics on Linux on this laptop.

## Usage

### NixOS

#### Install

- Install NixOS
- Bootstrap the config (should just work™);
    - Available profiles are:
        - `P50-personal`
        - `P50-work` (will only be accessible if you can unlock `git-crypt`)

```bash
# copy-paste the following once you understand what it's doing

# navigate to root home dir
cd /home &&

# clone home config
sudo nix-shell --run "git clone https://github.com/mhwdvs/hm" -p git &&

# build config
sudo nixos-rebuild switch --flake './hm/.#<your profile>' &&

# set password of new user
sudo passwd matthew

# give user ownership of config
cd sudo chown -R matthew /home/hm
```

#### Rebuild

- `my-nixos-rebuild`

### Nix (on non-NixOS host)

TODO
