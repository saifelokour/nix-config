{}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    historySubstringSearch.enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "ls --color=auto -F";
      nixswitch = "darwin-rebuild switch --flake ~/.config/system-config/.#";
      nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
    };
  };
}

