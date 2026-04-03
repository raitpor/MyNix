{ config, pkgs, ... }:
{
  # --- 编辑器: Neovim (LazyVim 风格配置) ---
  # 这里使用简化的配置，实际生产环境建议单独 git clone LazyVim 配置到 ~/.config/nvim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    #    plugins = with pkgs.vimPlugins; [
    #      lazy-vim
    #      lazy-lua
    #      nvim-treesitter.withAllGrammars
    #      telescope-nvim
    #      nvim-lspconfig
    #      luasnip
    #      friendly-snippets
    # Rime 支持 (如果需要直接在 nvim 中使用输入法框架，通常由系统接管)
    #    ];
  };
}
