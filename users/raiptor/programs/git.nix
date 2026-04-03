{ config, pkgs, ... }:
{
  # --- Git 配置 ---
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "raitpor";
        email = "928890461@qq.com";
      };
      init.defaultBranch = "main";
      core.editor = "nvim";
      safe.directory = "/etc/nixos";
      credential.helper = "store";
    };
  };
}
