{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/90743b97-0b54-45e5-8550-d0cbac218fe1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3606-9FF7";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/a8db5131-8feb-4caf-8813-7cb7092d1858"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    i2c.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = [ pkgs.amdvlk ];
    };
    pulseaudio = {
      enable = false;
      systemWide = false;
      support32Bit = true;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      package = pkgs.pulseaudioFull;
      extraConfig = ''
        load-module module-switch-on-connect
      '';
    };
    sensor.iio.enable = true;
    # high-resolution display
    video.hidpi.enable = true;
  };
}
