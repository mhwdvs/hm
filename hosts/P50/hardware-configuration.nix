# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/74431ebf-9ff5-49d4-80ac-898e1e50b3c8";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EA5E-E6EC";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6e33fbc5-9825-41f3-a977-d2e4c542e8d8"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}