{ config, pkgs, ... }:

{
  imports = [
    ./asdf.nix
    ./crystal.nix
    ./direnv
    ./emacs
    ./git.nix
    ./hammerspoon
    ./nodejs.nix
    ./prettier
    ./python
    ./ranger
    ./ripgrep.nix
    ./ruby.nix
    ./rust
    ./scripts
    ./telegram
    ./topgrade
    ./yabaiScripts
    ./zsh
  ];

  programs = {
    crystal.enable = false;
    emacs = { enable = true; };
    git = {
      enable = true;
      pager = "diff-so-fancy";
    };
    go.enable = true;
    nodejs = {
      enable = true;
      yarn.enable = true;
    };
    python = {
      enable = true;
      extraPackages = with pkgs.python3Packages; [ codecov grip jedi poetry ];
      black.enable = true;
      mypy.enable = true;
      pipx.enable = true;
      pylint.enable = true;
    };
    topgrade = {
      enable = true;
      config = {
        disable = [ "emacs" "gem" ];
        gitRepos = [ "~/.emacs.d" ];
      };
    };
    ruby = {
      enable = false;
      enableBuildLibs = true;
      provider = "nixpkgs";
      enableSolargraph = true;
    };
  };
}
