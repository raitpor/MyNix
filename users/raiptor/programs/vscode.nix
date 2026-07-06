{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        redhat.java
        vscjava.vscode-spring-initializr
        vscjava.vscode-maven
        vscjava.vscode-java-debug
        vscjava.vscode-java-test
        vscjava.vscode-gradle
        vscjava.vscode-java-dependency
        usernamehw.errorlens
        ms-ceintl.vscode-language-pack-zh-hans
        jdinhlife.gruvbox
        jnoortheen.nix-ide
        brettm12345.nixfmt-vscode
        ms-python.python
        ms-python.vscode-pylance
        vscodevim.vim
        jebbs.plantuml
        rust-lang.rust-analyzer
        fill-labs.dependi
        tamasfe.even-better-toml
      ];
    };
  };
}
