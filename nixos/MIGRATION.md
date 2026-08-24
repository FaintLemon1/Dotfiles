# Migración de Nixvim a Neovim + Home Manager

Esta configuración usa una sola regla de propiedad:

- Nix instala Neovim, plugins, parsers de Tree-sitter y servidores LSP.
- Lua configura el comportamiento del editor.
- No se usan Nixvim, LazyVim, Mason ni `:TSInstall`.

## 1. Copiar los archivos

Desde la raíz de tu repositorio (`~/nixos`), copia el contenido de este paquete
conservando las rutas. Los archivos `flake.nix`, `hosts/mamalona/home.nix` y
`modules/home/dev.nix` sustituyen sus versiones actuales.

La carpeta nueva es:

```text
modules/home/neovim/
├── default.nix
└── config/
    ├── init.lua
    └── lua/cesar/
        ├── appearance.lua
        ├── completion.lua
        ├── documents.lua
        ├── keymaps.lua
        ├── lsp.lua
        ├── navigation.lua
        ├── noice.lua
        ├── options.lua
        ├── snippets.lua
        └── treesitter.lua
```

Cuando confirmes que todo funciona, elimina el módulo antiguo:

```bash
rm modules/home/nixvim.nix
```

El archivo está controlado por Git, así que esta eliminación es recuperable.

## 2. Actualizar el lock sin actualizar todo nixpkgs

Nixvim fue retirado de `flake.nix`. Para retirar también sus nodos no utilizados
de `flake.lock`, ejecuta:

```bash
nix flake lock
```

No hace falta ejecutar `nix flake update`, que también cambiaría las revisiones
de nixpkgs, Home Manager y Zen Browser.

## 3. Evaluar antes de activar

Primero construye la configuración sin cambiar el sistema activo:

```bash
sudo nixos-rebuild build --flake .#nixos
```

Si termina correctamente:

```bash
sudo nixos-rebuild switch --flake .#nixos
```

## 4. Comprobar Neovim

Abre Neovim sin un archivo y ejecuta:

```vim
:checkhealth
```

Después revisa específicamente:

```vim
:checkhealth vim.lsp
:checkhealth vim.treesitter
:checkhealth vimtex
:checkhealth noice
:checkhealth which-key
```

Al abrir un archivo, confirma su tipo y los clientes LSP:

```vim
:set filetype?
:LspInfo
```

## 5. Flujo de LaTeX

La distribución completa de TeX vive en `dev.nix`, por lo que `latexmk`, biber,
ChkTeX, latexindent y los paquetes `.sty` también funcionan desde la terminal.
Zathura se usa como visor PDF con SyncTeX.

Las herramientas generales de `dev.nix` incluyen GCC/GDB para C, Python y el
toolchain básico de Rust (`rustc`, Cargo y rustfmt). Los proyectos más grandes
pueden migrarse después a un `devShell` propio sin cambiar Neovim.

Atajos principales:

| Atajo | Acción |
|---|---|
| `<Space>tc` | Iniciar/detener compilación continua de VimTeX |
| `<Space>tv` | Abrir el PDF o hacer búsqueda hacia delante |
| `<Space>ts` | Detener el compilador |
| `<Space>te` | Mostrar errores de compilación |
| `<Space>ti` | Mostrar información de VimTeX |
| `,ll` | Atajo tradicional de VimTeX para compilar |

Texlab proporciona completado, referencias y diagnósticos, pero no compila al
guardar. Esto evita tener dos procesos de compilación: VimTeX es el responsable
de llamar a latexmk.

### Snippets

Escribe el disparador y pulsa `<Tab>`:

| Disparador | Resultado |
|---|---|
| `beg` | `\\begin{entorno} ... \\end{entorno}` |
| `dm` | Bloque `\\[ ... \\]` |
| `eq` | Entorno `equation*` |
| `ali` | Entorno `align*` |
| `frac` | `\\frac{numerador}{denominador}` |
| `item` | `\\item` |

`friendly-snippets` agrega snippets generales; los anteriores son personales y
están en `snippets.lua`, donde puedes modificarlos sin tocar Nix.

## 6. Autocompletado

Solo se usa `nvim-cmp`. Blink fue eliminado porque dos motores de completado no
deben controlar simultáneamente el menú.

| Atajo | Acción |
|---|---|
| `<C-Space>` | Abrir completado manualmente |
| `<C-n>` / `<C-p>` | Selección siguiente/anterior |
| `<CR>` | Confirmar únicamente el elemento seleccionado |
| `<Tab>` | Elegir siguiente opción o expandir/saltar un snippet |
| `<S-Tab>` | Volver dentro de un snippet |
| `<C-d>` / `<C-u>` | Desplazar documentación |

Las fuentes son LSP, LuaSnip, rutas y palabras del buffer. En LaTeX se añade
`cmp-vimtex` con prioridad mayor para comandos, citas, etiquetas y referencias.

## 7. Navegación y documentos

| Atajo | Acción |
|---|---|
| `<Space>e` | Abrir/cerrar nvim-tree |
| `<Space>ff` | Buscar archivos con Telescope |
| `<Space>fg` | Buscar texto con ripgrep |
| `<Space>fb` | Buscar buffers abiertos |
| `<Space>fh` | Buscar en la ayuda |
| `<Space>mr` | Activar/desactivar render de Markdown |
| `<Space>cv` | Activar/desactivar vista CSV |
| `<Space>cc` | Activar/desactivar colores CSS |

CSVView se activa automáticamente en CSV/TSV. Render Markdown se muestra en
modo normal y deja visible el texto fuente al insertar. Colorizer muestra una
muestra al lado de colores CSS y también entiende expresiones `xcolor` en TeX.

## 8. Riesgos conocidos

### Noice

Noice usa una API experimental de interfaz de Neovim. Está aislado en
`noice.lua` y no se le permite reemplazar el renderizado de documentación de
LSP/cmp. Si desaparecen mensajes o la línea de comandos se comporta raro,
comenta esta línea en `config/init.lua`:

```lua
-- require("cesar.noice")
```

Después reconstruye. No necesitas retirar el paquete inmediatamente.

### Tree-sitter

La API reciente de nvim-treesitter es incompatible con muchos ejemplos
antiguos. Esta configuración no llama a `require("nvim-treesitter.configs")`:
usa `vim.treesitter.start()` y parsers precompilados por Nix.

### Home Manager y `~/.config/nvim`

No vuelvas a crear un enlace manual para toda la carpeta:

```nix
home.file.".config/nvim".source = ...;
```

Eso competiría con `programs.neovim`. Home Manager genera `init.lua` y enlaza
solamente `lua/cesar`, por lo que cada ruta tiene un único propietario.

## 9. Diagnóstico rápido

Si Neovim no arranca, evita temporalmente toda la configuración con:

```bash
nvim --clean
```

Para localizar el módulo que falla:

```bash
nvim --startuptime /tmp/nvim-startup.log
```

Dentro de Neovim también son útiles:

```vim
:messages
:Noice history
:VimtexInfo
:LspInfo
```
