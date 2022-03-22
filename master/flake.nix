{
  description = ''OpenStreetMap Overpass API Lib'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-overpass-master.flake = false;
  inputs.src-overpass-master.owner = "juancarlospaco";
  inputs.src-overpass-master.ref   = "master";
  inputs.src-overpass-master.repo  = "nim-overpass";
  inputs.src-overpass-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-overpass-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-overpass-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}