{ config, pkgs, inputs, ... }:
{
  home.username = "raiptor";
  home.homeDirectory = "/home/raiptor";
  home.stateVersion = "25.11"; 
  
  # 导入官方提供的 Git 和 Fish 模块
  programs.home-manager.enable = true;

  imports = [
    ./programs/fish.nix
    ./programs/kitty.nix
    ./programs/vscode.nix
    ./programs/neovim.nix
    ./programs/git.nix
  ];

  xdg.configFile."niri/config.kdl".source = ./configs/niri/config.kdl;

  programs.btop.enable = true;

  # --- 开发环境管理: Direnv + Mise ---
  # Direnv: 自动加载 .envrc
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # --- 常用开发工具包 ---
  home.packages = with pkgs; [
    # 基础工具
    git
    gh # GitHub CLI
    curl
    wget
    jq
    ripgrep
    fd
    fzf
    bat
    eza # ls 的现代替代品
    yazi
    fastfetch
    
    # 语言运行时 (具体版本可由 mise 管理，这里安装通用编译器)
    rustup
    python3
    conda
    nodejs_20
    jdk17
    
    # 容器与云
    docker-compose
    kubectl
    
    # AI 客户端
    ollama # 命令行客户端
    # openclaw (假设是某个特定工具，若不存在可用 curl/httpie 替代)
    
    # 浏览器 (Niri 需要)
    firefox
  ];
}
