pkgs: _:

let
  mkPythonApplication = file: args: pkgs.writeShellApplication ({
    text = "${pkgs.python3}/bin/python3 ${file} \"$@\"";
  } // args);
in {
  # fman = pkgs.writeShellApplication {
  #   name = "fman";
  #   runtimeInputs = with pkgs; [ fzf man ];
  #   text = builtins.readFile ./fman.sh;
  # };

  xdg-xmenu = mkPythonApplication ./xdg-xmenu.py {
    name = "xdg-xmenu";
    runtimeInputs = [ pkgs.imagemagick ];
  };

}

