{ config, pkgs, ... }:
let 
  # helper variables
  CONFIG_FILE = "${builtins.getEnv}";
  HARDWARE_CONFIG_FILE = /. + builtins.toPath /etc/nixos/hardware-configuration.nix;
  HM_FILE = /. + builtins.toPath ../../home/hm.nix;
  
  #NIX_REBUILD_COMMAND = "echo ${CONFIG_FILE} && echo ${HARDWARE_CONFIG_FILE} && echo ${HM_FILE} && nixos-rebuild -I nixos-config=\"${CONFIG_FILE}\" switch";

  # shell script to offload an application to the DGPU
  # Usage: nvidia-offload <3D-accelerated application>
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export DRI_PRIME=1
    exec -a "$0" "$@"
  '';
  
  # shell script to use this config from other directories
  #my-nixos-rebuild = pkgs.writeShellScriptBin "my-nixos-rebuild" NIX_REBUILD_COMMAND;
in
{
  imports = [ 
      HARDWARE_CONFIG_FILE  # from NixOS install
      HM_FILE
    ];

  # install shell scripts
  environment.systemPackages = [ 
    nvidia-offload 
    #my-nixos-rebuild
  ];
 
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Australia/Perth";

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matthew = {
    isNormalUser = true;
    home = "/home/matthew";
    description = "Matthew Davis";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

  system.autoUpgrade.enable = true;

  # Grub menu detects other OSs
  boot.loader.grub.useOSProber = true;

}

