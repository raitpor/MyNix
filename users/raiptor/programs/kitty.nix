{config,pkgs,...}:
{
  # --- 终端: Kitty (GPU 加速) ---
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.9";
      cursor_blink_interval = -1;
    };
  };
}
