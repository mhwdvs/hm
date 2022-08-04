# hm

My NixOS/home-manager configuration (with great inspiration taken from [Opeik's Nix/NixOS/home-manager config](https://github.com/opeik/nix))

## What's special

- Wrapped `nixos-rebuild` and `nixos-upgrade` scripts for each profile (eg `P50-personal-nixos-rebuild`) that is automatically made accessible system-wide
    - Can switch configurations without having to navigate to this repo or remember the non-trivial `sudo nixos-rebuild switch --flake <directory>/.#<profile>` command in 6 months time
- `nvidia-offload` script for hybrid graphics on my Lenovo P50 (your mileage may vary on other laptops) that allows you to offload specific graphically-intense processes to the dedicated GPU, or not and use integrated graphics for better power efficiency. AFAIK there is no better solution for hybrid graphics on Linux on this laptop.

## Usage

### Nix

```
NIXPKGS_ALLOW_UNFREE=1 nix build --show-trace .#general --extra-experimental-features nix-command --extra-experimental-features flakes --impure

NIXPKGS_ALLOW_UNFREE=1 nix run --show-trace .#general --extra-experimental-features nix-command --extra-experimental-features flakes --impure
```

- Where `general` is the desired configuration

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

Thank you https://github.com/kunxi/nix-config/ and https://dee.underscore.world/blog/home-manager-flakes/ <3

- Install `nix`

```sh
curl -L https://nixos.org/nix/install | sh source $HOME/.nix-profile/etc/profile.d/nix.sh
```

- Install `home-manager`

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

- Bootstrap `git` and this config

```
nix-env -iA nixpkgs.gitAndTools.gitFull
mv ~/.config/nixpkgs ~/.config/nixpkgs-origin
git clone https://github.com/kunxi/nix-config.git ~/.config/nixpkgs
```

- Build the config

```
nixFlakes build '.#homeConfigurations."someuser@somecomputer".activationPackage'
```

- Activate the config

```
./build/activate
```

## Navigation

- `home` contains shared, general configuration to be used by all configurations
- `hosts` contains shared configuration for specific hardware devices
- `profiles` contains unique configuration for different use cases (eg. work, school)

