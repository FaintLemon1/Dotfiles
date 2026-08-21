{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    colorschemes.everforest= {
      enable = true;

      settings = {
	transparent= true;
    background = "hard";
    ui_contrast = "high";
  };
	#settings.transparent = false;
      #settings.style = "night"; # consistente con tu tema en SwayNC
    };

    globalOpts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      wrap = true;        # cómodo para prosa (tex/md)
      linebreak = true;
      spell = true;
      spelllang = [ "es" "en" ];
    };

    # --- Tree-sitter, sin compilación en runtime ---
    plugins.treesitter = {
      enable = true;
      settings.highlight.enable = true;
      settings.indent.enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        latex
        bibtex
        markdown
        markdown_inline
        csv
        yaml
        nix
        vim
        vimdoc
      ];
    };

    # --- LSPs: texlab (LaTeX) y marksman (Markdown) ---
    plugins.lsp = {
      enable = true;
      servers = {
        texlab.enable = true;
        marksman.enable = true;
      };
    };

    # Autocompletado básico (opcional pero recomendado con lsp)
    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
      	{ name = "luasnip"; }
       	{ name = "vimtex"; }
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
    };

    # --- LaTeX: compilar y ver el PDF ---
    plugins.vimtex = {
      enable = true;
	

	texlivePackage = null;

      settings = {
        compiler_method = "latexmk";
        view_method = "zathura";
        quickfix_mode = 0;
      };
    };

    # --- CSV ---
    plugins.csvview.enable = true;

    # --- Markdown ---
    plugins.render-markdown = {
      enable = true;
      settings.file_types = [ "markdown" ];
    };

    plugins.telescope.enable = true;
    plugins.noice.enable = true;
    plugins.nvim-tree.enable =true;
    plugins.nvim-autopairs.enable = true;
    plugins.which-key.enable = true;

    plugins.blink-cmp = {
    enable = true;

    settings = {
      sources.default = [
        "lsp"
        "path"
        "buffer"
      ];
    };
    };
    plugins.cmp-vimtex.enable = true;

    plugins.luasnip = {
  	enable = true;
    };

	
    extraPlugins = with pkgs.vimPlugins; [
      luasnip-latex-snippets-nvim
    ];

    extraConfigLua = ''
      require("luasnip-latex-snippets").setup()
    '';

	# Paquetes externos necesarios en runtime (compilador LaTeX + visor PDF)
    extraPackages = with pkgs; [
      #texliveMedium   # cambia a texlive.combined.scheme-full si te falta algún paquete .sty
      #zathura
    ];
  };

}
