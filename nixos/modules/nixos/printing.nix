{ pkgs, ... }:

{
   services.printing = {   # CUPS - servicio de impresión
		enable = true; 
	};



  services.avahi = {
		enable = true;
   		nssmdns4 = true;
   		openFirewall = true;  # abre UDP 5353
 	};

}
