{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Estos programas quedan disponibles dentro de Neovim. Los servidores
    # LSP se instalan con Nix; Mason no es necesario.
    extraPackages = with pkgs; [
      ripgrep
      fd

      texlab
      marksman
      nil
      lua-language-server
      clang-tools
      rust-analyzer
      pyright
      vscode-langservers-extracted
      bash-language-server
      yaml-language-server

      nixfmt
      stylua

      # render-markdown puede convertir fórmulas sencillas a Unicode.
      python3Packages.pylatexenc
    ];

    plugins = with pkgs.vimPlugins; [
      # Apariencia e iconos.
      everforest
      nvim-web-devicons

      # Navegación.
      plenary-nvim
      telescope-nvim
      nvim-tree-lua
      which-key-nvim

      # Interfaz. Noice se configura de manera conservadora y puede
      # desactivarse comentando una sola línea en config/init.lua.
      nui-nvim
      nvim-notify
      noice-nvim

      # LSP y autocompletado.
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-vimtex
      luasnip
      friendly-snippets
      nvim-autopairs

      # Documentos.
      
      # Previsualización matemática dentro de Neovim.
      nabla-nvim
      vimtex
      csvview-nvim
      render-markdown
      nvim-colorizer-lua

      # Parsers compilados por Nix. No se usa :TSInstall.
      (nvim-treesitter.withPlugins (parsers: with parsers; [
        bash
        bibtex
        c
        csv
        css
        html
        javascript
        json
        latex
        lua
        markdown
        markdown_inline
        nix
        python
        regex
        rust
        toml
        vim
        vimdoc
        yaml
      ]))
    ];

    initLua = builtins.readFile ./config/init.lua;
  };

  # init.lua lo genera programs.neovim; el resto permanece en archivos Lua
  # normales, para poder usar directamente la documentación de los plugins.
  xdg.configFile."nvim/lua/cesar".source = ./config/lua/cesar;
}
