{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.ungoogled-chromium ];
}
