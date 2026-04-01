{config,pkgs,...}:
{
	# --- Shell: Fish + Starship ---
	  programs.fish = {
	    enable = true;
	    shellAliases = {
	      ll = "ls -la";
	      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#thinkbook";
	      gc = "sudo nix-collect-garbage -d";
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
	      character = { success_symbol = "[➜](bold green)"; error_symbol = "[✗](bold red)"; };
	    };
	  };
}
