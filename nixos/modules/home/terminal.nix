#terminal packages 
{ pkgs, ... }:

{
	home.packages = with pkgs; [
		
	kitty #terminal
	termdown #terminal cound_down
	zathura #terminal_pdfreader
	tree #terminal
	yazi #terminal_archive_manager
	git # tool_for_github
	github-cli #git login tool
	#neovim #editor de codigo desde la terminal
	fastfetch #terminal desktop description
	pdftk #tool for pdf 
	cmatrix # matrix from terminal 
	uxplay # reproducir iphone
	ripgrep
	fd

	];
}
