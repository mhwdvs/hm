{ config, pkgs, ... }:
let 
  # shell script to use this config from other directories
  my-nixos-rebuild = pkgs.writeShellScriptBin "my-nixos-rebuild" ''
    echo "Building P50 configuration"
    sudo nixos-rebuild -I nixos-config="/home/hm/machines/P50.nix" switch
  '';

  # shell script to offload an application to the DGPU
  # Usage: nvidia-offload <3D-accelerated application>
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export DRI_PRIME=1
    exec -a "$0" "$@"
  '';
in
{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ../home/general.nix
    ../home/hm.nix
  ];

  # install shell scripts
  environment.systemPackages = [ 
    nvidia-offload 
    my-nixos-rebuild
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Grub menu detects other OSs
  boot.loader.grub.useOSProber = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
