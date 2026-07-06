{ config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs;[
      proton-ge-bin
    ]
  };

  # To make sure Steam starts a game with GameMode, right click the game, select Properties..., then Launch Options and enter: 
  # gamemoderun %command%

  # To run games with GameMode start it like this: 
  # gamemoderun ./game
  programs.gamemode.enable = true;

  users.extraGroups.gamemode.members = [ "raiptor" ];
}
