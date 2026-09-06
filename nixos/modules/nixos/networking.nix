#modules/networking.nix
{ config, ... }:
{
  networking = {
	hostName = "T14"; # Define your hostname.
	nameservers = [ "1.1.1.1" "1.0.0.1" ];
	#enableIPv6 = false;

	networkmanager = {
		enable = true;
	};
	modemmanager = {
		enable = true;
	};
  };
networking.firewall.interfaces."enp0s31f6" = {
  allowedUDPPorts = [
    53 # DNS
    67 # DHCP
  ];

  allowedTCPPorts = [
    53 # DNS
  ];
};
}

