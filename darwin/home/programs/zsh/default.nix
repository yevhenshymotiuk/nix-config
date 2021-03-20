{ pkgs, ... }:

{
  # imports = [ ./forgit.nix ];

  home.packages = with pkgs; [ zsh-completions ];

  home.file.".zpreztorc".source = ./zpreztorc;
  home.file.".zsh_completions".source = ./completions;
  home.file.".p10k-pure.zsh".source = ./p10k-pure.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    # loginExtra = ''
    #   ssh-add -D
    #   ssh-add $HOME/.ssh/id_rsa
    # '';
    initExtra = ''
      export HISTSIZE=1000
      export SAVEHIST=1000

      source ~/.p10k-pure.zsh
      if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
      fi
    '';
    envExtra = ''
      fpath+=$HOME/.zsh_completions

      export ERL_AFLAGS="-kernel shell_history enabled"
      export PYENV_ROOT="$HOME/.pyenv"
      export GOPATH="$HOME/go"
      # export DARTPATH=$(dirname $(dirname $(readlink $(which dart))))

      export PATH="$PYENV_ROOT/bin:$PATH"
      export PATH="$HOME/.mix/escripts:$PATH"
      export PATH="$GOPATH/bin:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker" "docker-compose" "wd" "z" ];
    };
    plugins = with pkgs; [
      {
        name = "prezto";
        src = fetchFromGitHub {
          owner = "sorin-ionescu";
          repo = "prezto";
          rev = "2d6205e71404704eecc4f402e5b09d7cbd19bab7";
          sha256 = "1ks4vzgh033aw7xr10q1cy6ikmhwz2qbqiqb7056sb0y8kmh86wh";
          fetchSubmodules = true;
        };
        file = "init.zsh";
      }
      rec {
        name = "fast-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zdharma";
          repo = name;
          rev = "d8e5bbe3dade87216d1a0dddb59a1c148b206e24";
          sha256 = "1na4clk4lcv849gidfn72vp1ycww3pxl41fgkq453i55g9mx2say";
        };
      }
    ];
    shellAliases = {
      cat = "bat";
      cdr = "cd $(git rev-parse --show-toplevel)";
      drel = "direnv reload";
      drs = "darwin-rebuild switch";
      git = "hub";
      golines = "golines -w -m 80";
      gomodifytags = "gomodifytags -add-tags json -all -w -file";
      grep = "rg";
      ls = "exa --group-directories-first";
      tg = "topgrade -y";
    };
  };
}
