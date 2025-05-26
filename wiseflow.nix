{stdenv, requireFile, dpkg, buildFHSEnv, makeWrapper, webkitgtk_4_0, gtk3, glib, gdk-pixbuf, xorg, gnome-screenshot, gnomeScreenshotProvider ? gnome-screenshot, lib}:

let
  wiseflow-unwrapped = stdenv.mkDerivation rec {
    name = "wiseflow_device_monitor-unwrapped";
    version = "2.4.3";

    src = requireFile rec {
      name = "wiseflow_device_monitor_2.4.3_linux.deb";
      url = "https://europe.wiseflow.net/account/invigilation";
      sha256 = "sha256-uP7XGcSSDemNL00G9Q+udstYRnTZz1A5YqcX/AcHuVs=";
    };

    nativeBuildInputs = [ dpkg ];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp /build/root/usr/bin/wiseflow-device-monitor $out/bin/
      install -Dm444 -t $out/share/applications /build/root/usr/share/applications/wiseflow-device-monitor.desktop
      runHook postInstall
    '';

    dontConfigure = true;
    dontBuild = true;
    dontStrip = true;
    dontPatchELF = true;
  };
in
buildFHSEnv {
  name = "wiseflow-device-monitor";

  targetPkgs = pkgs: with pkgs; [
    wiseflow-unwrapped
    webkitgtk_4_0
    gtk3
    glib
    gdk-pixbuf
    xorg.xwininfo
    gnomeScreenshotProvider
  ];

  extraInstallCommands = ''
    ln -s ${wiseflow-unwrapped}/share $out/share
  '';

  runScript = "wiseflow-device-monitor";

  meta = {
    platforms = [ "x86_64-linux" ];
  };
}
