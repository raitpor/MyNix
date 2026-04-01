{ config, pkgs, ... }:
{
  security.sudo.wheelNeedsPassword = false; # 开发机方便起见，生产环境请设为 true
  networking.firewall.enable = true;
}
