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
      ipykernel
    ];
  pythonWithMyPackages = python.withPackages myPythonPackages;
in {
  imports = [ ./black ./mypy ./pipx ./pylint ];

  options.programs.python = {
    enable = mkEnableOption "Python language support";
    extraPackages = mkOption {
      default = with pythonPackages; [ ];
      type = with types; listOf package;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pythonWithMyPackages ] ++ cfg.extraPackages;

    programs.zsh = {
      envExtra = ''
        export PYTHONBREAKPOINT=ipdb.set_trace
      '';
    };

    home.file.".pdbrc".source = ./.pdbrc;
  };
}
