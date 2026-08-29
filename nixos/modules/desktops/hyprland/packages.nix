{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #cosas de hyprland
    hyprland
    hyprlock
    hyprpaper

    # barra superior
    waybar

    #cosas que uso para swaync y notificaciones
    swaynotificationcenter
    libnotify
    brightnessctl
    lm_sensors
    blueman #
    pavucontrol #

    #menu de apliaciones
    wofi 

	
    #capturas de pantalla
    slurp
    grim

    #portapapeles
    wl-clipboard
    playerctl


  ];
}
