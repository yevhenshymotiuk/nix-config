{ config, pkgs, ... }:

{
  imports = [
    ./calendar-to-org.nix
    ./imap.nix
    ./skhd.nix
    # ./sortdir.nix
    ./spacebar.nix
    ./spotifyd.nix
    ./yabai.nix
  ];
}
