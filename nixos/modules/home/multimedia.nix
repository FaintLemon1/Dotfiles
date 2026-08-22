{ pkgs, ... }:
{
	home.packages = with pkgs; [
		mpv
		smplayer
		vlc
	];
}
