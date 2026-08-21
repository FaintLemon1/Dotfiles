{ config, pkgs, ... }:
{
# configuration for steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    gamemode
    prismlauncher
    discord
  ];

}
