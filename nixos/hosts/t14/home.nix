{ config, pkgs, ... }:

{
  imports = [
    ../../modules/desktops/hyprland/default.nix

    ../../modules/home/neovim
    ../../modules/home/multimedia.nix
    ../../modules/home/dev.nix
    ../../modules/home/terminal.nix
    ../../modules/home/games.nix
    ../../modules/home/programs.nix
  ];

  home.username = "cesar";
  home.homeDirectory = "/home/cesar";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    obsidian
    thunar
    obs-studio
    #freecad-wayland 
    spotify
    qbittorrent	
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
}
