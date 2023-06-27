({ pkgs, ... }: {
  # here go the darwin preferences and config items
  programs.zsh.enable = true;
  environment = {
    shells = with pkgs; [ bash zsh ];
    loginShell = pkgs.zsh;
    systemPackages = with pkgs; [ coreutils ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.remapCapsLockToEscape = true;
  fonts.fontDir.enable = false;
  fonts.fonts =
    [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
  services.nix-daemon.enable = true;
  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder._FXShowPosixPathInTitle = true;
    dock.autohide = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    #NSGlobalDomain.InitialKeyRepeat = 14;
    #NSGlobalDomain.KeyRepeat = 1;
  };

  users.users.saif.home = "/Users/saif";

  # backwards compat; don't change
  system.stateVersion = 4;
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    masApps = {
      "AdBlock Pro" = 1018301773;
      "Guidance" = 412759995;
      "Xcode" = 497799835;
    };
    casks = [
      "alfred"
      "betterdisplay"
      "calibre"
      "coconutbattery"
      "discord"
      "docker"
      "figma"
      "google-chrome"
      "karabiner-elements"
      "miro"
      "ngrok"
      "notion"
      "rectangle"
      "slack"
      "signal"
      "surfshark"
      "whatsapp"
      "zoom"
      "zulip"
      "macfuse"
      "gromgit/fuse/mounty"
    ];
    taps = [ ];
    brews = [ ];
  };
})

