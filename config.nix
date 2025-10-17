{
  lib,
  pkgs,
  ...
}:
let
  sources = import ./npins;
  mnw = import sources.mnw;
in
{

  initLua = ''
    vim.g.mapleader = " "
    vim.g.maplocalleader = " "
     LZN = require("lz.n")
    LZN.load("lazy")
  '';

  aliases = [
    "v"
    "vi"
  ];

  plugins = {
    start = [
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.nvim-treesitter-textobjects
    ]
    ++ mnw.lib.npinsToPlugins pkgs ./start.json;
    opt = mnw.lib.npinsToPlugins pkgs ./opt.json;

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
    fd
    stylua
    deadnix
    statix
    nixd
  ];
}
