{config,pkgs,...}:
{
  # --- Git 配置 ---
  programs.git = {
    enable = true;
    userName = "raitpor";
    userEmail = "928890461@qq.com"; # 请修改
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
      safe.directory = "/etc/nixos";
    };
  };
}
