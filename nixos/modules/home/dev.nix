{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode

    # Flujo completo de LaTeX. scheme-full incluye latexmk, biber,
    # latexindent, chktex, paquetes matemáticos y fuentes de TeX.
    texliveFull
    zathura
    python3Packages.pygments # Necesario para documentos que usan minted.

    # Herramientas generales de desarrollo.
    gcc
    gdb
    gnumake
    cmake
    pkg-config
    ncurses
    python3
    rustc
    cargo
    rustfmt
  ];
}
