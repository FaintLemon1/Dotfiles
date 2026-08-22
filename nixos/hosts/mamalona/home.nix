{ config, pkgs, inputs, ... }:

{ 
  imports = [
  	../../modules/desktops/hyprland/default.nix

	 inputs.nixvim.homeManagerModules.nixvim
    	../../modules/home/nixvim.nix

	../../modules/home/multimedia.nix	
	../../modules/home/dev.nix	
	../../modules/home/terminal.nix	
  ];

  #programs.lazyvim = {
   # enable = true;
    #extras = {
      #lang.nix.enable = true;
     # lang.python = {
       # enable = true;
        #installDependencies = true;       # instala ruff
    #    #installRuntimeDependencies = true; # instala python3
     # };
      #lang.go.enable = true;
      # ...así con cualquier extra que LazyVim ofrezca
    #};
  #};

  home.username = "cesar";
  home.homeDirectory = "/home/cesar";

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    fastfetch
    btop
    brightnessctl
    blueman
    wl-clipboard
    playerctl
    libnotify
    ];

  programs.git.enable = true;
  programs.home-manager.enable = true;
  xdg.enable = true;

  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink "/home/cesar/Dotfiles/config/hypr";

  home.file.".config/waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/home/cesar/Dotfiles/config/waybar";

  home.file.".config/swaync".source =
    config.lib.file.mkOutOfStoreSymlink "/home/cesar/Dotfiles/config/swaync";

  #home.file.".config/nvim".source =
   # config.lib.file.mkOutOfStoreSymlink "/home/cesar/Dotfiles/config/nvim";


 xdg.desktopEntries.prismlauncher-offload = {
  name = "Prism Launcher (NVIDIA)";
  exec = "nvidia-offload prismlauncher %u";
  icon = "org.prismlauncher.PrismLauncher";
  categories = [ "Game" ];
};

}
