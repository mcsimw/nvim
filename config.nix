{
  lib,
  pkgs,
  ...
}:
let
  sources = import ./npins;

  mnw = import sources.mnw;

  #  blink-cmp =
  #    (import sources.flake-compat {
  #      src = sources."blink.cmp";
  #    }).defaultNix.packages.${pkgs.system}.blink-cmp;
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
    start = mnw.lib.npinsToPlugins pkgs ./start.json;

    opt = [
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.nvim-treesitter-textobjects
      #      blink-cmp
    ]
    ++ mnw.lib.npinsToPlugins pkgs ./opt.json;

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
    lua-language-server
    stylua
    gnutar
    curl
    fzf
    haskell-language-server
    tinymist
  ];
}
