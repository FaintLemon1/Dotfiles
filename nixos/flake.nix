{
	description  = " una configuracion muy basica de nix";
	
	inputs = { 
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		zen-browser = {
      			url = "github:youwen5/zen-browser-flake";
      			inputs.nixpkgs.follows = "nixpkgs";
    		};
		home-manager = {
  			url = "github:nix-community/home-manager";
  			inputs.nixpkgs.follows = "nixpkgs";
		};
		nixvim = {
      			url = "github:nix-community/nixvim";
      			inputs.nixpkgs.follows = "nixpkgs";
		};
	};
	
	outputs = { self, nixpkgs, zen-browser, home-manager, nixvim,  ... }@inputs: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			modules = [
				./hosts/mamalona/configuration.nix
				
			home-manager.nixosModules.home-manager
			{
		            home-manager.useGlobalPkgs = true;
		            home-manager.useUserPackages = true;
			    home-manager.extraSpecialArgs = { inherit inputs; };   # <- esto es lo que falta
		            home-manager.users.cesar = import ./hosts/mamalona/home.nix;
          		}

			 ({ pkgs, ... }: {
          			environment.systemPackages = [
            			zen-browser.packages.${pkgs.system}.default
          			];
        		})
			];
		};
	};
}
