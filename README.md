# hm
My NixOS/home-manager configuration

## What's special

- Wrapped `nixos-rebuild` script (`my-nixos-rebuild`) that is automatically made accessible system-wide - install and somewhat forget

## Usage

### NixOS

#### Install

- Install NixOS
- Bootstrap the config (should just work™);

```bash
su root && # ensure we are root
cd ~ && # navigate to root home dir
nix-shell --run "wget -c https://github.com/matthew/hm/archive/master.tar.gz && tar --strip-components=1 -xvf master.tar.gz" -p wget && # download home config
nixos-rebuild -I nixos-config="/root/hm/machines/<desired machine>.nix" switch && # build config
passwd matthew # set password of new user
```

#### Rebuild

- `my-nixos-rebuild`



