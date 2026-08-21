# shell.nix

{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ zsh-powerlevel10k ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    shellAliases = {
      #...
    };
    setOptions = [
      "AUTO_CD"
    ];

    loginShellInit = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
        exec start-hyprland
      fi
    '';
    ohMyZsh = {
      enable = true;
      theme  = "robbyrussell"; 
      plugins = [ "git" "dirhistory" "history" ];
    };
  };
  users.defaultUserShell = pkgs.zsh;
  system.userActivationScripts.zshrc = "touch .zshrc";
  environment.shells = with pkgs; [ zsh ];
}
