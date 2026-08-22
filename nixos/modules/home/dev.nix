{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
		vscode # editor de codigo
		texliveFull #latex
		gcc #c
		ncurses #clib
		python3 #pyton
	];
}
