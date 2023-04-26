{ ... }:

self: super:
{
  # NOTE Switch back to src build when issue is fixed
  yabai = super.yabai.overrideAttrs (o: rec {
    version = "5.0.3";
    src = builtins.fetchTarball {
      url =
        "https://github.com/koekeishiya/yabai/releases/download/v${version}/yabai-v${version}.tar.gz";
      sha256 = "1l306siwdv84m4az40dg30jrmrh4apjy0dhhmdqmgqg9p3z74f77";
    };

    installPhase = ''
      mkdir -p $out/bin
      mkdir -p $out/share/man/man1/
      cp ./bin/yabai $out/bin/yabai
      cp ./doc/yabai.1 $out/share/man/man1/yabai.1
    '';
  });
}
