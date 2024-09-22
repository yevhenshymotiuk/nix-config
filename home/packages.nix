{ pkgs, ... }:

{
  home.packages = with pkgs;
    let
      comma = (import
        (builtins.fetchTarball {
          url = "https://github.com/Shopify/comma/archive/master.tar.gz";
          sha256 = "0xcld2ncs8dnidpl7kz8x1s01c0qc4d2s87jvqlks8laqf7czsay";
        })
        { });
      myTexlive = (texlive.combine {
        inherit (texlive)
          capt-of
          cyrillic
          scheme-basic
          etoolbox
          fontawesome
          metafont
          microtype
          nopageno
          siunitx
          ulem
          wrapfig
          xcolor;
      });
    in
    [
      # development
      asciinema
      awscli2
      cachix
      caddy
      cmake
      editorconfig-core-c
      erlang
      elixir
      exercism
      gawk
      # gitAndTools.git-hub
      gobject-introspection
      httpie
      # imagemagick
      jq
      kubectl
      lua
      luaPackages.lua-lsp
      minikube
      myTexlive
      nasm
      nil
      openmpi
      plantuml
      pre-commit
      p7zip
      redis
      # sass
      tokei
      unrar
      unzip

      # nix stuff
      # comma
      nix-prefetch-github
      nixpkgs-fmt
      nixpkgs-review
      patchelf

      # documents
      graphviz
      pandoc

      # communication
      isync
      mu
      tmate

      # monitoring
      neofetch
      speedtest-cli

      # passwords & security
      openssl

      # net & cloud tools
      aria2
      ddgr
      doctl
      # httpie
      netcat
      rclone
      inetutils

      # entertainment
      mpv
      # portaudio
      # spotifyd
      streamlink
      yt-dlp

      # other
      fd
      ffmpeg
      # gimp
      hexyl
      hyperfine
      my.ical2org
      # obs-studio
      pastel
      tealdeer
      termdown
      translate-shell
    ];
}
