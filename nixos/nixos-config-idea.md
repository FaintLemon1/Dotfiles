/etc/nixos
├── flake.nix
├── flake.lock
│
├── hosts
│   └── mamalona
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       ├── graphics.nix
│       └── home.nix
│
└── modules
    ├── desktops
    │   ├── hyprland
    │   │   ├── nixos.nix
    │   │   ├── home.nix
    │   │   └── packages.nix
    │   ├── plasma
    │   │   ├── nixos.nix
    │   │   └── home.nix
    │   └── xfce
    │       ├── nixos.nix
    │       └── home.nix
    │
    ├── nixos
    │   ├── gaming.nix
    │   ├── printing.nix
    │   └── virtualization.nix
    │
    └── home
        ├── latex.nix
        ├── multimedia.nix
        ├── nixvim.nix
        └── terminal.nix
