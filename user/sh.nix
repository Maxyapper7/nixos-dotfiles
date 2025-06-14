{ config, pkgs, userSettings, ... }:
let

  myAliases = {
    hms = "home-manager switch --flake ~/dotfiles#user";
    nrs = "sudo nixos-rebuild switch --flake /home/${userSettings.username}/dotfiles#system";
    updt = "nix flake update --flake ~/dotfiles";
    nixgc = "nix-collect-garbage --delete-older-than 10d";
    ls = "eza --icons -l -T -L=1";
    cat = "bat";
    htop = "btm";
    neofetch = "disfetch";
    tailup = "sudo tailscale up --accept-routes --exit-node=toronto";
    taildown = "sudo tailscale down";
  };
in
{

  home.packages = with pkgs; [
    bottom
      disfetch
      eza
      fd
      fzf
      unzip
      zsh
      zsh-fzf-history-search
      zsh-fzf-tab
    bat
    git
  ];

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    shellAliases = myAliases;
    initContent = ''
#    PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
#     %F{green}→%f "
#    RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
#    [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    bindkey '^P' history-beginning-search-backward
    bindkey '^N' history-beginning-search-forward
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    zstyle ':completion:*' menu no
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
    zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
    eval "$(fzf --zsh)"
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';
  };

  home.file = {
    ".config/eza".source = ../dotfiles/eza;
  };


}
