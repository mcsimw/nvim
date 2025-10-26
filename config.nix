{
  lib,
  pkgs,
  ...
}:
let
  sources = import ./npins;

  mnw = import sources.mnw;

  importFlakePackage =
    name: attr:
    (import sources.flake-compat {
      src = sources.${name};
    }).defaultNix.packages.${pkgs.system}.${attr};

  blink-cmp = importFlakePackage "blink.cmp" "blink-cmp";
  lzn = importFlakePackage "lz.n" "default";
in
{

  initLua = ''
    LZN = require("lz.n")
    LZN.load("lzn")
  '';

  aliases = [
    "v"
    "vi"
  ];

  plugins = {
    start = [ lzn ];

    opt = [
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.nvim-treesitter-textobjects
      blink-cmp
    ]
    ++ mnw.lib.npinsToPlugins pkgs ./plugins.json;

    dev.mcsimw = {
      pure =
        let
          fs = lib.fileset;
        in
        fs.toSource {
          root = ./.;
          fileset = fs.unions [
            ./plugin
            ./after
            ./lua
          ];
        };
      impure = "/mnt/nyx/nvim";
    };
  };

  providers = {
    ruby.enable = false;
    python3.enable = false;
    nodeJs.enable = false;
    perl.enable = false;
  };

  extraBinPath = with pkgs; [
    ripgrep
    git
    fd
    stylua
    deadnix
    statix
    nixd
    nixfmt
    lua-language-server
    stylua
    gnutar
    curl
    fzf
    haskell-language-server
    tinymist
    viu
    chafa
    ueberzugpp
    tree-sitter
    llvmPackages_21.clang-tools
    ormolu
    ghc
    nodejs_24
    prettier
    prettierd
    rustfmt
    black
    isort
    mercurial
  ];
}
