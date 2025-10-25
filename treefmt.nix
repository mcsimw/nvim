{
  projectRootFile = "flake.nix";
  settings.global.excludes = [
    "npins"
    "plugins.json"
  ];
  programs = {
    nixfmt.enable = true;
    stylua.enable = true;
  };
}
