{config,pkgs,...}:
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
	  usernamehw.errorlens
	  ms-ceintl.vscode-language-pack-zh-hans
	  jdinhlife.gruvbox
      ];
    };
  };
}
