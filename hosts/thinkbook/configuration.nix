{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common/locale.nix
    ../../modules/common/security.nix
  ];

  # --- 基础系统设置 ---
  networking.hostName = "thinkbook";
  networking.networkmanager.enable = true;
  system.stateVersion = "25.11"; 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # 国内镜像加速 (清华源)
  nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  #nix.settings.trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];

  # --- 引导加载程序: Limine ---
  # 注意：确保你之前已经正确安装了 limine 到 EFI 分区
  boot.loader.limine = {
    enable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  
  # --- 内核与硬件驱动 (Intel Ultra 125H) ---
  # Intel Ultra 需要较新的内核 (6.8+) 以完美支持 Arc 核显和能效
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # 启用 Intel 微码
  hardware.cpu.intel.updateMicrocode = true;

  # 图形加速 (Intel Arc / Xe)
  hardware.graphics = {
    enable = true;
  };

  #hardware.buletooth.enable = true;

  # --- 桌面环境: SDDM + Niri (Wayland) ---
  # Niri 是一个创新的滚动式 Wayland 合成器
  services.xserver.enable = true; # 为了兼容部分 X11 应用 (via Xwayland)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # SDDM 支持 Wayland 会话
  };
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  
  programs.niri = {
    enable = true;
    package = pkgs.niri; # 确保 nixpkgs 版本够新
  };

  # --- 中文输入环境: Fcitx5 + Rime ---
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-gtk
    ];
    fcitx5.waylandFrontend = true;
  };

  # --- 字体: FiraCode Nerd Font ---
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  # --- 容器化: Docker ---
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  # 将用户加入 docker 组 (在 users 模块或这里处理，推荐在 users 模块)
  users.users.raiptor = {
    isNormalUser = true;
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
  };

  # --- AI 工具: Ollama ---
  services.ollama = {
    enable = true;
  };

  #dolphin挂载u盘服务
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    fastfetch
    kdePackages.dolphin
    adwaita-icon-theme
  ];

  # --- 其他服务 ---
  programs.fish.enable = true; # 系统级启用 Fish
  programs.starship.enable = true;

  # 允许非自由软件 (如需专有驱动或固件)
  nixpkgs.config.allowUnfree = true;
}
