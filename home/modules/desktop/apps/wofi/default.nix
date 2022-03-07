{ config, lib, mylib, pkgs, ... }:

with lib;
with mylib;
let cfg = config.programs.wofi; in
{
  options.programs.wofi = {
    enable = mkEnableOption "Wofi launcher/menu for wlroots based compositors";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wofi ];

    xdg.configFile."wofi/style.css".source = toCSSFile ./style.sass;
  };
}
