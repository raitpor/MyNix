{ config, pkgs, ... }:
{
  # --- Shell: Fish + Starship ---
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza -al --color=always --group-directories-first --icons"; # preferred listing
      la = "eza -a --color=always --group-directories-first --icons"; # all files and dirs
      ll = "eza -l --color=always --group-directories-first --icons"; # long format
      lt = "eza -aT -L 2 --color=always --group-directories-first --icons"; # tree listing
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#thinkbook --option substituters \"https://mirrors.ustc.edu.cn/nix-channels/store\"";
      gc = "sudo nix-collect-garbage -d";
      jctl = "journalctl -p 3 -xb";
    };
    interactiveShellInit = ''
      	      starship init fish | source
      	      fastfetch
      	    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
    };
  };
}
