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
cd /home && # navigate to root home dir
sudo nix-shell --run "git clone https://github.com/mhwdvs/hm" -p git && # clone home config
sudo nixos-rebuild -I nixos-config="/home/hm/machines/<desired machine>.nix" switch && # build config
sudo passwd matthew # set password of new user
cd sudo chown -R matthew /home/hm
```

#### Rebuild

- `my-nixos-rebuild`

## Troubleshooting

- GNOME touchpad gestures stopped working (typically three-finger up/down for dash)

For some reason these only work on Wayland, so either just switch to Wayland:tm: or [install a GNOME extension to fix gestures in X11](https://extensions.gnome.org/extension/4033/x11-gestures/)
