{ config, lib, pkgs, ... }:

{
  home-manager.users.yevhenshymotiuk = { pkgs, ... }: {
    home.packages = with pkgs; [ elixir erlang ];
    programs = {
        git.gpgKey = "684AD74F3CE22ECC";
    };
  };
}
