#configuracion de cosas relacionadas con el host
# Thinkpad  T14 Gen2
{ config, pkgs, ... }:
{
	imports = [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/gaming.nix
      ../../modules/nixos/shell.nix
      ../../modules/nixos/printing.nix
      ../../modules/nixos/networking.nix
      ../../modules/nixos/bluetooth.nix
      ../../modules/nixos/syncthing.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;  # Use latest kernel.
  boot.extraModprobeConfig = ''
  	options thinkpad_acpi fan_control=1
  '';

  ## configuration.nix  ######################
	
  time.timeZone = "America/Mexico_City";   # Set your time zone.
  i18n.defaultLocale = "en_US.UTF-8";   # Select internationalisation properties.

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
  hyprpolkitagent
  rpi-imager  
	wireplumber   # provee wpctl
	bluez     
  blueman #gestor_de_bluetoth
 ];


#some fonts for waybar icons and etc.
	#fonts.packages = [ "JetBrains Mono" ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
	fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono

      # Para poder probarlas después:
      ibm-plex
      iosevka
    ];

    fontconfig.defaultFonts = {
      monospace = [
        "JetBrainsMono Nerd Font"
      ];
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:
  #services.desktopManager.plasma6.enable = true;
  services.udisks2.enable = true;
  security.polkit = {
    enable = true;
    enablePkexecWrapper = true;
  };
  services.tailscale.enable = true;
  services.power-profiles-daemon.enable = false;
  services.getty.autologinUser = "cesar"; #autologin
  
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

#services.syncthing = {
#    enable = true;
#    group = "users";
#    user = "cesar";
#    dataDir = "/home/cesar/life";
#    configDir = "/home/cesar/.config/syncthing";
#    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
#    overrideFolders = true;     # overrides any folders added or deleted through the WebUI
#
#    settings = {
#      devices = {
#        "iphone" = { id = "PUUWPWF-WNLP6KA-TUEHIB3-RYPRO4L-5FTSUFM-ESLMU5V-COS4IZC-MDH7TQ3"; };
#      };
#      folders = {
#        "life" = {         # Name of folder in Syncthing, also the folder ID
#          path = "/home/cesar/life";    # Which folder to add to Syncthing
#          devices = [ "iphone" ];      # Which devices to share the folder with
#        };
#
#        };
#    };
#  };

 
  system.stateVersion = "25.11"; # Did you read the comment?
  environment.variables = {
  EDITOR = "nvim";
  VISUAL = "nvim";
};


 

  
}
