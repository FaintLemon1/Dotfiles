{ ... }:

{
  services.syncthing = {
    enable = true;

    user = "cesar";
    group = "users";

    # Queremos que sus datos/configuración pertenezcan a tu usuario.
    dataDir = "/home/cesar";

    # La GUI queda solo accesible desde esta máquina.
    guiAddress = "127.0.0.1:8384";

    # Abre 22000 TCP/UDP y 21027 UDP en el firewall de NixOS.
    openDefaultPorts = true;

    # Lo definido aquí será la fuente de verdad.
    overrideDevices = true;
    overrideFolders = true;

    settings = {
      devices = {
        "mamalona-server" = {
          id = "7EB5GVQ-W6NMICZ-IV2IDIZ-3ENXI2B-EXEBUNS-S2PYL66-XMJQUKG-FFFIYQX";
        };
      };

      folders = {
        "synccarpet" = {
          id = "9e62e-ee3tp";
          label = "Prueba Sync";

          path = "/home/cesar/syncthing";

          devices = [
            "mamalona-server"
          ];

          type = "sendreceive";
        };
      };
    };
  };
}
