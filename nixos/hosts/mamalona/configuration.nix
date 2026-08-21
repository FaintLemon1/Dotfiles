#configuracion de cosas relacionadas con el host
# Thinkpad P15 Gen1


{ config, pkgs, ... }:

{
	imports = [ # Include the results of the hardware scan.
      ../../hardware-configuration.nix
      ../../modules/system/gaming.nix
      ../../modules/graphics.nix
      ../../modules/shell.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
 
  # configuration.nix

	hardware.nvidia = {
	  modesetting.enable = true;
	  open = false;  # O true si usas el driver open-source
	};
	
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.extraModprobeConfig = ''
  	options thinkpad_acpi fan_control=1
  '';

  networking = {
	hostName = "nixos"; # Define your hostname.
	nameservers = [ "1.1.1.1" "1.0.0.1" ];
	enableIPv6 = false;

	networkmanager = {
		enable = true;
	};
	modemmanager = {
		enable = true;
	};

  };

  # Set your time zone.
  time.timeZone = "America/Mexico_City";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cesar = {
    isNormalUser = true;
    description = "cesar";
    extraGroups = [ "plugdev" "networkmanager" "wheel" "input" "uinput"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
  "nix-command"
  "flakes"
];

  services.displayManager.defaultSession = "hyprland";
  programs.hyprland.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	
	nvtopPackages.full # nvidia monitor 
	wireplumber   # provee wpctl
	
	bluez     
  	blueman #gestor_de_bluetoth

	kdePackages.okular #pdfreader
  	vlc # video_media_player
  	

	vscode # editor de codigo
	
	texliveFull #latex
	
	spotify #music reproduction

	thunar

	freecad-wayland 
	
	obsidian
	
	#terminal things
	
	kitty #terminal


	termdown #terminal cound_down
	zathura #terminal_pdfreader
	tree #terminal
	yazi #terminal_archive_manager
	git # tool_for_github
	neovim #editor de codigo desde la terminal
	fastfetch #terminal desktop description
	pdftk #tool for pdf 


	#streaming and record screeen
	#obs-studio

	# torrents
	qbittorrent

	gcc #c
	ncurses #clib
	python3
	
	ncspot #musica 

	github-cli


	teams-for-linux #microsoftteamsforlinux
	##	tools ###
	#ventoy-full #insecure 	
	uxplay # para reproducir iphone en laptop

  ];


#some fonts for waybar icons and etc.
 	fonts.packages = with pkgs; [
  		nerd-fonts.jetbrains-mono
  		nerd-fonts.fira-code
	];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:
  services.desktopManager.plasma6.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  services.tailscale.enable = true;


  services.power-profiles-daemon.enable = false;

  services = {
	getty = {
		autologinUser = "cesar";
	};

	printing = {   # CUPS - servicio de impresión
		enable = true; 
	};
	avahi = {
		enable = true;
   		nssmdns4 = true;
   		openFirewall = true;  # abre UDP 5353
 	};

  };
  
services.tlp = {
  enable = true;
  settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

    CPU_MIN_PERF_ON_AC = 0;
    CPU_MAX_PERF_ON_AC = 100;
    CPU_MIN_PERF_ON_BAT = 0;
    CPU_MAX_PERF_ON_BAT = 20;

    # Battery thresholds (adjust BAT0/BAT1 based on your laptop model)
    START_CHARGE_THRESH_BAT0 = 75; # Starts charging when battery is below this %
    STOP_CHARGE_THRESH_BAT0 = 80;  # Stops charging when battery reaches this %
  };
};

services.syncthing = {
    enable = true;
    group = "users";
    user = "cesar";
    dataDir = "/home/cesar/life";
    configDir = "/home/cesar/.config/syncthing";
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
    overrideFolders = true;     # overrides any folders added or deleted through the WebUI

    settings = {
      devices = {
        "iphone" = { id = "PUUWPWF-WNLP6KA-TUEHIB3-RYPRO4L-5FTSUFM-ESLMU5V-COS4IZC-MDH7TQ3"; };
      };
      folders = {
        "life" = {         # Name of folder in Syncthing, also the folder ID
          path = "/home/cesar/life";    # Which folder to add to Syncthing
          devices = [ "iphone" ];      # Which devices to share the folder with
        };

        };
    };
  };

  hardware.uinput.enable = true; # usado por sunshine para emular teclado

  system.stateVersion = "25.11"; # Did you read the comment?
  environment.variables = {
  EDITOR = "nvim";
  VISUAL = "nvim";
};


 

  
}
