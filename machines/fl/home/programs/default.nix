{ lib, pkgs, ... }:

{
  imports = [
    ./mako
    ./telegram
    ./waybar
    ./wluma
    ./wofi
  ];

  programs = {
    emacs.enable = true;
    firefox.package = pkgs.firefox-wayland;
    git.gpgKey = "4B0D9393F36E588A";
    mbsync.enable = true;
    zsh.loginExtra = ''[[ "$(tty)" == /dev/tty1 ]] && sway'';
  };
}
