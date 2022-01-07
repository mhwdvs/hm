# Lenovo P50 (4K PANTONE, 2016)
# In BIOS enable "Hybrid Graphics"
{ pkgs, ... }:
let 
  # shell script to use this config from other directories
  P50-personal-nixos-rebuild = pkgs.writeShellScriptBin "P50-personal-nixos-rebuild" ''
    echo "Building P50-personal configuration"
    sudo nixos-rebuild switch --flake '/home/hm/.#P50-personal'
  '';
  P50-personal-nixos-upgrade = pkgs.writeShellScriptBin "P50-personal-nixos-upgrade" ''
    echo "Upgrading P50-personal configuration"
    sudo nixos-rebuild switch --flake '/home/hm/.#P50-personal' --upgrade
  '';
  P50-work-nixos-rebuild = pkgs.writeShellScriptBin "P50-work-nixos-rebuild" ''
    echo "Building P50-work configuration"
    sudo nixos-rebuild switch --flake '/home/hm/.#P50-work'
  '';
  P50-work-nixos-upgrade = pkgs.writeShellScriptBin "P50-work-nixos-upgrade" ''
    echo "Upgrading P50-work configuration"
    sudo nixos-rebuild switch --flake '/home/hm/.#P50-work' --upgrade
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
    ./hardware-configuration.nix
  ];

  # install shell scripts
  environment.systemPackages = [ 
    # scripts
    P50-personal-nixos-rebuild
    P50-personal-nixos-upgrade
    P50-work-nixos-rebuild
    P50-work-nixos-upgrade
    nvidia-offload 

    # GNOME
    pkgs.gnome.gnome-tweaks
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

  # Laptop power management settings in GNOME
  powerManagement.cpuFreqGovernor = "powersave";

  # validity VFS7500 fingerprint reader
  #services.fprintd.enable = true;
  #services.fprintd.tod.enable = true;
  #services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;
}