{ config, pkgs, ... }:
{
  programs.conda = {
    enable = true;
    mirror = "https://mirrors.tuna.tsinghua.edu.cn/anaconda";
  };
}
