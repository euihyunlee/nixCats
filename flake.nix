{
  description = "Neovim configurations based on nixCats";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixCats,
    ...
  } @ inputs: let
    inherit (nixCats) utils;

    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;

    luaPath = ./.;

    categoryDefinitions = {
      pkgs,
      settings,
      categories,
      extra,
      name,
      mkPlugin,
      ...
    } @ packageDef: {
      lspsAndRuntimeDeps.general = with pkgs; [
        fd
        ripgrep

        # Lua
        lua-language-server
        stylua

        # Nix
        alejandra
        nixd

        # LaTeX
        tex-fmt
        texlab

        # TypeScript
        typescript-language-server
        svelte-language-server
      ];

      startupPlugins.general = with pkgs.vimPlugins; [
        lz-n
      ];

      optionalPlugins.general = with pkgs.vimPlugins; [
        blink-cmp
        catppuccin-nvim
        conform-nvim
        friendly-snippets
        gitsigns-nvim
        lazydev-nvim
        lualine-nvim
        nvim-lspconfig
        (nvim-treesitter.withPlugins (
          plugins:
            with plugins; [
              bash
              c
              c_sharp
              cmake
              cpp
              css
              cuda
              dockerfile
              elixir
              erlang
              gleam
              go
              heex
              html
              javascript
              json
              lua
              make
              markdown
              markdown_inline
              meson
              ninja
              nix
              python
              query
              rust
              scss
              sql
              svelte
              typescript
              vim
              vimdoc
              wgsl
              xml
              yaml
              zig
            ]
        ))
        nvim-web-devicons
        plenary-nvim
        telescope-nvim
        telescope-fzf-native-nvim
        which-key-nvim
      ];
    };

    packageDefinitions = {
      nixCats = {
        pkgs,
        name,
        ...
      } @ misc: {
        settings = {
          wrapRc = true;
          suffix-path = true;
          suffix-LD = true;
          aliases = ["nvim"];
        };

        categories.general = true;
      };
    };

    defaultPackageName = "nixCats";
  in
    forEachSystem (system: let
      nixCatsBuilder = utils.baseBuilder luaPath {inherit nixpkgs system;} categoryDefinitions packageDefinitions;

      defaultPackage = nixCatsBuilder defaultPackageName;

      pkgs = import nixpkgs {inherit system;};
    in {
      packages = utils.mkAllWithDefault defaultPackage;

      devShells = {
        default = pkgs.mkShell {
          name = defaultPackageName;
          packages = [defaultPackage];
          inputsFrom = [];
          shellHook = ''
          '';
        };
      };
    })
    // (let
      nixosModule = utils.mkNixosModules {
        inherit nixpkgs luaPath categoryDefinitions packageDefinitions defaultPackageName;
        moduleNamespace = [defaultPackageName];
      };

      homeModule = utils.mkHomeModules {
        inherit nixpkgs luaPath categoryDefinitions packageDefinitions defaultPackageName;
        moduleNamespace = [defaultPackageName];
      };
    in {
      inherit utils nixosModule homeModule;

      nixosModules.default = nixosModule;
      homeModules.default = homeModule;
    });
}
