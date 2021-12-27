{ pkgs, ... }:

{
  home.packages = with pkgs;
    let
      comma = (import (builtins.fetchTarball {
        url = "https://github.com/Shopify/comma/archive/master.tar.gz";
        sha256 = "0n5a3rnv9qnnsrl76kpi6dmaxmwj1mpdd2g0b4n1wfimqfaz6gi1";
      }) { });
      myTexlive = (texlive.combine {
        inherit (texlive)
          scheme-basic etoolbox fontawesome microtype siunitx xcolor;
      });
    in [
      # development
      asciinema
      awscli
      cachix
      caddy
      cmake
      dart
      # deno
      editorconfig-core-c
      elixir
      erlang
      exercism
      gawk
      gdb
      ghc
      gitAndTools.git-hub
      gitAndTools.gh
      glib
      gnupg
      gobject-introspection
      gofumpt
      imagemagick
      ix
      jq
      kubectl
      libpng
      libpqxx
      lld_10
      lua
      luaPackages.lua-lsp
      minikube
      myTexlive
      nasm
      nim
      # octave
      openmpi
      pipenv
      pkg-config
      plantuml
      protobuf
      redis
      rnix-lsp
      ruby
      sass
      shellcheck
      shfmt
      unrar
      unzip
      wakatime

      # nix stuff
      # comma
      fd
      nixfmt
      nix-index
      nix-prefetch-github
      nixpkgs-fmt
      nixpkgs-review
      patchelf

      # documents
      graphviz
      pandoc

      # other ART (Awesome Rust Tools)
      diskus
      du-dust
      fd
      ffsend
      hexyl
      hyperfine
      just
      lsd
      pastel
      ruplacer
      sd
      tealdeer
      tokei
      xsv

      # communication
      isync
      mu
      offlineimap
      protonmail-bridge
      tmate

      # monitoring
      neofetch
      gotop
      speedtest-cli

      # passwords & security
      gopass
      pass
      pinentry

      # net & cloud tools
      ddgr
      doctl
      httpie
      netcat
      rclone
      telnet

      # entertainment
      epr
      mpv
      # portaudio
      # spotifyd
      spotify-tui
      streamlink
      transmission
      youtube-dl

      # my stuff
      navi
      termdown
      translate-shell
    ];
}
