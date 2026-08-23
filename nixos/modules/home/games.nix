#games configuration
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gamemode
    prismlauncher
    discord
  ];

}
