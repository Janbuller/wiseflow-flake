{stdenv, writeShellApplication, grim, wl-clipboard, slurp, lib}:
writeShellApplication {
  name = "gnome-screenshot";
  runtimeInputs = [ grim wl-clipboard slurp ];
  text = builtins.readFile ./grim-gnome-screenshot.sh;
}
