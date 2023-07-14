{ pkgs, nixvim, ... }: {
  imports = [ nixvim.homeManagerModules.nixvim ];
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = with pkgs; [
    asdf-vm
    sqlite
    cmake
    curl
    wget

    erlang
    elixir
    unison-ucm
    cbqn
    efm-langserver
    nodePackages.prettier

    wxGTK32
    gnutls
    fd
    ffmpeg
    jq
    lazygit
    ncdu
    pngpaste
    terminal-notifier
    xclip
    ripgrep
    mpw

    luarocks
    luaformatter

    transmission
    nodePackages.webtorrent-cli
    youtube-dl
    # flexget

    iterm2
    postgresql
  ];
  xdg.enable = true;
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  programs.git = {
    enable = true;
  };
  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.exa.enable = true;
  programs.zsh = (pkgs.callPackage ./programs/zsh.nix { }).programs.zsh;
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      return {
      	font = wezterm.font("JetBrains Mono"),
      	color_scheme = "OneHalfBlack (Gogh)",
      	hide_tab_bar_if_only_one_tab = true,
      	window_decorations = "RESIZE",
      }
    '';
  };

  programs.nixvim = (pkgs.callPackage ./programs/nvim.nix { inherit pkgs; }).programs.nixvim;
}

