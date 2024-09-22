{ inputs, lib, pkgs, ... }:

with lib.my; {
  imports = [ ./hardware.nix ../../platforms/nixos ../../platforms/nixos/graphical ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
    extraModprobeConfig = ''
      options hid_apple iso_layout=0
    '';
    initrd.kernelModules = [
      "usbhid"
      "usb_storage"
      "sdhci_pci"
    ];
    kernelParams = [ "apple_dcp.show_notch=1" ];
  };

  zramSwap.enable = true;

  nixpkgs.overlays = [
    inputs.nixos-apple-silicon.overlays.apple-silicon-overlay
  ] ++ (mapModules' ./overlays (p: import p { inherit inputs lib; }));

  environment.systemPackages = with pkgs; [ vulkan-validation-layers ];

  networking = {
    useDHCP = lib.mkDefault true;
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };

  services.logind = {
    powerKey = "ignore";
    suspendKey = "ignore";
  };
}
