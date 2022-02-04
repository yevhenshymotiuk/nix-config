{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.programs.python;
  python = pkgs.python3;
  pythonPackages = pkgs.python3Packages;
  myPythonPackages = pythonPackages:
    with pythonPackages; [
      # setup
      pip
      setuptools
      wheel

      # ipython
      ipdb
    ];
  pythonWithMyPackages = python.withPackages myPythonPackages;
in {
  options.programs.python = {
    enable = mkEnableOption "Python language support";
    extraPackages = mkOption {
      default = with pythonPackages; [ ];
      type = with types; listOf package;
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      envExtra = ''
        export PYTHONBREAKPOINT=ipdb.set_trace
      '';
    };

    home = {
      file.".pdbrc".source = ./.pdbrc;
      packages = [ pythonWithMyPackages ] ++ cfg.extraPackages;
    };
  };
}
