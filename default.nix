let
  sources = import ./npins;
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  augmentedSources = sources // {
    nvim-treesitter = sources.nvim-treesitter // {
      rev = sources.nvim-treesitter.revision;
    };
    nvim-treesitter-textobjects = sources.nvim-treesitter-textobjects // {
      rev = sources.nvim-treesitter-textobjects.revision;
    };
  };

  mkPkgs =
    system:
    import sources.nixpkgs {
      inherit system;
      overlays = [
        (import sources.neovim-nightly-overlay)
        (import "${sources.nvim-treesitter-main}/overlay.nix" { inputs = augmentedSources; })
        (final: prev: {
          vimPlugins = prev.vimPlugins.extend (
            f: p: {
              nvim-treesitter = p.nvim-treesitter.withAllGrammars;
              nvim-treesitter-textobjects = p.nvim-treesitter-textobjects.overrideAttrs {
                dependencies = [ f.nvim-treesitter ];
              };
            }
          );
        })
      ];
    };

  treefmt-nix = import sources.treefmt-nix;
  mnw = import sources.mnw;

  mkOutputs =
    system:
    let
      pkgs = mkPkgs system;
      treefmtEval = treefmt-nix.evalModule pkgs ./treefmt.nix;
      pkg = mnw.lib.wrap {
        inherit pkgs;
        inputs = sources;
      } ./config.nix;
    in
    {
      formatter = treefmtEval.config.build.wrapper;
      checks.formatting = treefmtEval.config.build.check ./.;
      packages = {
        default = pkg;
      };
      devShells = {
        default = pkgs.mkShellNoCC {
          packages = [
            pkg.devMode
            treefmtEval.config.build.wrapper
            pkgs.npins
          ];
        };
      };
    };

  outputs = builtins.listToAttrs (
    map (system: {
      name = system;
      value = mkOutputs system;
    }) systems
  );
in
{
  formatter = builtins.mapAttrs (_: v: v.formatter) outputs;
  checks = builtins.mapAttrs (_: v: v.checks) outputs;
  packages = builtins.mapAttrs (_: v: v.packages) outputs;
  devShells = builtins.mapAttrs (_: v: v.devShells) outputs;
}
