#modules/networking.nix
{ config, ... }:
{
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
}

