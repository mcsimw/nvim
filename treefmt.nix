{
  projectRootFile = "flake.nix";
  settings.global.excludes = [
    "npins"
    "opt.json"
    "start.json"
  ];
  programs = {
    nixfmt.enable = true;
    stylua.enable = true;
  };
}
