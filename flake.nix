{
  description = "Raiptor's Modern NixOS Configuration for ThinkBook 14 2025";

  inputs = {
    # NixPKGS: 使用 25.11 或 unstable 以获取最新软件 (Intel Ultra 需要较新内核)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    # Home Manager: 管理用户层配置
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS Hardware: 针对特定硬件的微调 (ThinkBook)
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    
    # Limine Bootloader Support (如果需要额外模块，通常 nixpkgs 已包含，此处作为示例保留)
    # 注意：Limine 通常在 configuration.nix 中通过 boot.loader 直接配置
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: {
    nixosConfigurations.thinkbook = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; # 将 inputs 传递给子模块
      modules = [
        # 1. 基础硬件配置 (需从 /etc/nixos 复制过来)
        ./hosts/thinkbook/hardware-configuration.nix
        
        # 2. 系统主配置
        ./hosts/thinkbook/configuration.nix
        
        # 3. 引入 NixOS Hardware 优化 (针对 Lenovo ThinkBook)
        # nixos-hardware.nixosModules.lenovo-thinkbook
	#./noctalia.nix

        # 4. 集成 Home Manager 作为系统模块
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.raiptor = {
	     imports = [ ./users/raiptor/home.nix];
	  };
          
          # 可选：全局 Home Manager 配置
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}
