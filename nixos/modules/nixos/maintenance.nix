{ ... }:
{
  # TRIM semanal para el SSD
  services.fstrim.enable = true;

  # Deduplicar archivos idénticos en /nix/store con hardlinks
  nix.settings.auto-optimise-store = true;

  # Recolección de basura automática
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Máximo de generaciones en el menú de arranque
  boot.loader.systemd-boot.configurationLimit = 10;
}
