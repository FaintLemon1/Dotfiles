#terminal packages 
{ pkgs, ... }:

{
	home.packages = with pkgs; [
	fastfetch
  foot #terminal
  fuzzel # 
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
  btop
  sshfs
  lazygit
  gdu
  p7zip
  sl
  tmux
  chafa ##for render images
 
 ###things for yocto
 bpftrace 
 gnumake 
 pkg-config 
 lttng-ust

  ##tools for the terminal
  cbonsai
  sl
  tty-clock
  cava
  fastfetch
  chafa
  figlet
  lolcat
  asciiquarium
	];

programs.foot = {
  enable = true;

  settings = {
    main = {
      # ---------------------------------------------------------
      # TERMINAL
      # ---------------------------------------------------------

      # Deja que Foot anuncie su terminfo real.
      # Fuera de tmux: TERM=foot
      term = "foot";

      # ---------------------------------------------------------
      # FUENTE
      # ---------------------------------------------------------

      # Fuente principal.
      # 11.5 es un buen tamaño si quieres aprovechar espacio.
      font = "JetBrainsMono Nerd Font:size=11.5";

      # Foot normalmente puede encontrar estas variantes solo,
      # pero definirlas explícitamente evita elecciones raras
      # de fontconfig.
      font-bold =
        "JetBrainsMono Nerd Font:style=Bold:size=11.5";

      font-italic =
        "JetBrainsMono Nerd Font:style=Italic:size=11.5";

      font-bold-italic =
        "JetBrainsMono Nerd Font:style=Bold Italic:size=11.5";

      # Usa correctamente el DPI reportado por Wayland.
      dpi-aware = "yes";

      # Espacio alrededor del contenido:
      #
      # horizontal x vertical
      #
      # 8x6 queda limpio sin desperdiciar demasiado espacio.
      pad = "8x6";
    };


    # -----------------------------------------------------------
    # SCROLLBACK
    # -----------------------------------------------------------

    scrollback = {
      # Foot por defecto mantiene relativamente poco historial.
      # 10k es cómodo y consume muy poco.
      lines = 10000;

      # Cuántas líneas mueve aproximadamente cada paso de rueda.
      multiplier = 3.0;

      # Muestra dónde estás dentro del historial.
      indicator-position = "relative";
    };


    # -----------------------------------------------------------
    # CURSOR
    # -----------------------------------------------------------

    cursor = {
      # block | beam | underline
      style = "block";

      # No parpadea.
      blink = "no";
    };


    # -----------------------------------------------------------
    # MOUSE
    # -----------------------------------------------------------

    mouse = {
      # Oculta el cursor mientras escribes.
      hide-when-typing = "yes";
    };


    # -----------------------------------------------------------
    # SEGURIDAD / CLIPBOARD
    # -----------------------------------------------------------

    security = {
      # OSC52 permite que programas como tmux escriban al
      # portapapeles del sistema.
      #
      # copy-enabled permite COPIAR hacia el clipboard,
      # pero no da acceso completo de lectura a las aplicaciones.
      osc52 = "copy-enabled";
    };


    # -----------------------------------------------------------
    # COLORES
    # -----------------------------------------------------------

    colors = {
      # 1.00 = completamente opaco
      # 0.95 = casi opaco
      # 0.90 = bastante agradable
      # 0.80 = bastante transparente
      #
      # 0.92 es mi recomendación para uso diario.
      alpha = 0.92;

      # Fondo
      background = "11111b";

      # Texto
      foreground = "cdd6f4";


      # Colores ANSI normales
      regular0 = "45475a";
      regular1 = "f38ba8";
      regular2 = "a6e3a1";
      regular3 = "f9e2af";
      regular4 = "89b4fa";
      regular5 = "f5c2e7";
      regular6 = "94e2d5";
      regular7 = "bac2de";


      # Colores ANSI brillantes
      bright0 = "585b70";
      bright1 = "f38ba8";
      bright2 = "a6e3a1";
      bright3 = "f9e2af";
      bright4 = "89b4fa";
      bright5 = "f5c2e7";
      bright6 = "94e2d5";
      bright7 = "a6adc8";
    };
  };
};

programs.tmux = {
  enable = true;


  # -------------------------------------------------------------
  # TERMINAL
  # -------------------------------------------------------------

  # Dentro de tmux queremos:
  #
  # echo $TERM
  # -> tmux-256color
  #
  # NO pongas xterm-256color manualmente.
  terminal = "tmux-256color";


  # -------------------------------------------------------------
  # NUMERACIÓN
  # -------------------------------------------------------------

  # Empieza windows y panes en 1 en vez de 0.
  #
  # Así:
  #
  # Ctrl+b 1
  # Ctrl+b 2
  # Ctrl+b 3
  #
  # coincide mejor con las teclas numéricas.
  baseIndex = 1;


  # -------------------------------------------------------------
  # MOUSE
  # -------------------------------------------------------------

  # Permite:
  #
  # - seleccionar panes con click
  # - seleccionar windows con click
  # - scroll
  # - resize de panes arrastrando bordes
  mouse = true;


  # -------------------------------------------------------------
  # COPY MODE
  # -------------------------------------------------------------

  # Navegación estilo Vim cuando estás en copy mode.
  keyMode = "vi";


  # -------------------------------------------------------------
  # LATENCIA
  # -------------------------------------------------------------

  # Reduce el tiempo que tmux espera después de ESC.
  #
  # Es particularmente agradable en Neovim/Vim.
  escapeTime = 0;


  # -------------------------------------------------------------
  # HISTORIAL
  # -------------------------------------------------------------

  # Historial propio de tmux.
  #
  # Aunque Foot tenga 10000 líneas, cuando estás dentro de tmux
  # el scrollback importante es este.
  historyLimit = 100000;


  # -------------------------------------------------------------
  # FOCUS
  # -------------------------------------------------------------

  # Informa a programas como Neovim cuando su pane obtiene
  # o pierde el foco.
  focusEvents = true;


  # -------------------------------------------------------------
  # RELOJ
  # -------------------------------------------------------------

  clock24 = true;


  # -------------------------------------------------------------
  # PLUGINS
  # -------------------------------------------------------------

  plugins = with pkgs.tmuxPlugins; [

    # Pequeño conjunto de defaults sensatos para tmux.
    sensible


    # Guarda sesiones/windows/panes para poder reconstruirlos.
    resurrect


    {
      plugin = continuum;

      extraConfig = ''
        # Restaura automáticamente la última sesión guardada
        # cuando tmux vuelve a arrancar.
        set -g @continuum-restore 'on'

        # Guarda aproximadamente cada 15 minutos.
        set -g @continuum-save-interval '15'
      '';
    }
  ];


  # -------------------------------------------------------------
  # CONFIGURACIÓN TMUX DIRECTA
  # -------------------------------------------------------------

  extraConfig = ''

    # ===========================================================
    # FOOT + TRUE COLOR
    # ===========================================================

    # Foot soporta RGB/24-bit.
    #
    # tmux moderno reconoce Foot directamente, pero dejar esta
    # línea explícita evita problemas en versiones/configuraciones
    # donde la detección falle.
    set -as terminal-features ',foot*:RGB'


    # ===========================================================
    # CLIPBOARD
    # ===========================================================

    # Permite a tmux usar OSC52 para copiar al clipboard
    # del terminal.
    #
    # Foot lo soporta.
    set -g set-clipboard on


    # ===========================================================
    # WINDOWS
    # ===========================================================

    # Si cierras una window intermedia:
    #
    # 1 2 3 4
    #
    # y cierras 2:
    #
    # automáticamente queda:
    #
    # 1 2 3
    #
    # en lugar de:
    #
    # 1 3 4
    set -g renumber-windows on


    # ===========================================================
    # CREAR WINDOWS CONSERVANDO EL DIRECTORIO
    # ===========================================================

    # Ctrl+b c
    #
    # crea una window nueva en el mismo directorio en el que
    # estás trabajando actualmente.
    bind c new-window -c "#{pane_current_path}"


    # ===========================================================
    # DIVIDIR PANES
    # ===========================================================

    # Ctrl+b |
    #
    # crea un pane a la derecha.
    #
    # -h significa horizontal respecto al eje,
    # visualmente genera columnas.
    bind | split-window -h -c "#{pane_current_path}"


    # Ctrl+b -
    #
    # crea un pane debajo.
    #
    # Conserva el directorio actual.
    bind - split-window -v -c "#{pane_current_path}"


    # ===========================================================
    # NAVEGACIÓN ENTRE PANES
    # ===========================================================

    # En lugar de:
    #
    # Ctrl+b + flecha
    #
    # también puedes usar estilo Vim:
    #
    # Ctrl+b h = izquierda
    # Ctrl+b j = abajo
    # Ctrl+b k = arriba
    # Ctrl+b l = derecha

    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R


    # ===========================================================
    # REDIMENSIONAR PANES
    # ===========================================================

    # La opción -r significa repeat.
    #
    # Después de Ctrl+b H puedes seguir pulsando H sin volver a
    # pulsar Ctrl+b cada vez.

    bind -r H resize-pane -L 5
    bind -r J resize-pane -D 5
    bind -r K resize-pane -U 5
    bind -r L resize-pane -R 5


    # ===========================================================
    # RECARGAR CONFIGURACIÓN
    # ===========================================================

    # Ctrl+b r
    #
    # recarga tmux.conf sin matar tu sesión.
    bind r source-file ~/.config/tmux/tmux.conf \; \
      display-message "tmux config recargada"


    # ===========================================================
    # STATUS BAR
    # ===========================================================

    # Barra arriba, como si fueran pestañas de navegador.
    set -g status-position top


    # Actualiza reloj/etc cada 5 segundos.
    set -g status-interval 5


    # Fondo default significa que utiliza el fondo transparente
    # de Foot en lugar de dibujar un rectángulo opaco.
    set -g status-style \
      'bg=default,fg=#a6adc8'


    # Nombre de la sesión a la izquierda.
    set -g status-left \
      '#[bold,fg=#89b4fa] #S #[default]'


    # Tamaño reservado para la izquierda.
    set -g status-left-length 30


    # Información del lado derecho.
    #
    # #H = hostname
    # %H:%M = hora
    set -g status-right \
      '#[fg=#6c7086]#H #[fg=#89b4fa]%H:%M '


    # Window inactiva.
    #
    # #I = número
    # #W = nombre
    set -g window-status-format \
      ' #I:#W '


    # Window actual.
    set -g window-status-current-format \
      '#[bold,fg=#89b4fa] #I:#W #[default]'


    # ===========================================================
    # BORDES DE PANES
    # ===========================================================

    # Paneles que no tienen foco.
    set -g pane-border-style \
      'fg=#45475a'


    # Panel actualmente seleccionado.
    set -g pane-active-border-style \
      'fg=#89b4fa'


    # ===========================================================
    # MENSAJES
    # ===========================================================

    set -g message-style \
      'bg=#1e1e2e,fg=#cdd6f4'


    # ===========================================================
    # SILENCIO
    # ===========================================================

    # Evita campanas molestas.
    set -g bell-action none
  '';
};
}
