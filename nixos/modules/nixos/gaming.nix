# modules/gaming.nix
# things about gaming 
{ config, lib, pkgs, ... }:

{
  # Compatibilidad gráfica para juegos de 32 bits.
  hardware.graphics.enable32Bit = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;

  hardware.uinput.enable = true; # usado por sunshine para emular teclado

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;
  };
}

