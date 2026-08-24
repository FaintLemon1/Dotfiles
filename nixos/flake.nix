{
  description = "Una configuración muy básica de NixOS";

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
  };

  outputs = { nixpkgs, zen-browser, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./hosts/mamalona/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.cesar = import ./hosts/mamalona/home.nix;
        }

        ({ pkgs, ... }: {
          environment.systemPackages = [
            zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
          ];
        })
      ];
    };
  };
}
