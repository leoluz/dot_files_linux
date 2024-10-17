{ config, pkgs, ... }:

{
  home.username = "leoluz";
  home.homeDirectory = "/home/leoluz";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # development
    gh

    # wayland
    wl-clipboard

    # archives
    zip
    xz
    unzip
    p7zip
    _7zz
    unrar

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fastfetch

    # misc
    tree

    # nix related
    nvd # nixos diff viewer
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    # nix-output-monitor

    # productivity
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    iperf # measure IP bandwidth

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # basic configuration of git, please change to your own
  # programs.git = {
  #   enable = true;
  #   userName = "Ryan Yin";
  #   userEmail = "xiaoyin_c@qq.com";
  # };
  #


  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
    localVariables = {
      GOBIN = "$HOME/go/bin";
      PATH = "$GOBIN:$PATH";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "refined";
      # theme = "kolo";
    };
  
    shellAliases = {
      ll = "eza -l --icons=auto";
      l = "eza -la --icons=auto";
      update = "sudo nixos-rebuild switch --flake .";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };

  programs.kitty = {
    enable = true;
    theme = "One Dark";
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      font_size = 14;
      font_family = "DejaVuSansM Nerd Font Mono";
      bold_font = "DejaVuSansM Nerd Font Mono Bold";
      italic_font = "DejaVuSansM Nerd Font Mono Oblique";
      bold_italic_font = "DejaVuSansM Nerd Font Mono Bold Oblique";
      font_features = "FiraCode-Regular +zero +onum";

      tab_title_template = "{index}: {title}";
      active_tab_title_template = "{index}[{num_windows}]: {title}";
      tab_bar_edge = "bottom";
      allow_remote_control = "yes";
      kitty_mod = "alt";
      enabled_layouts = "fat, tall, grid, stack";
      inactive_text_alpha = "0.5";
      tab_bar_style = "powerline";
      # background_opacity = "0.97";
      background_blur = 1;
      hide_window_decorations = "yes";
      background_tint = "0.7";
      close_on_child_death = "yes";
      scrollback_lines = 200000;
      mouse_hide_wait = 2;
      visual_bell_duration = 0;

      "map kitty_mod+s" = "new_window";
      "map kitty_mod+c" = "copy_to_clipboard";
      "map kitty_mod+v" = "paste_from_clipboard";
      "map kitty_mod+t" = "new_tab";
      "map kitty_mod+1" = "goto_tab 1";
      "map kitty_mod+2" = "goto_tab 2";
      "map kitty_mod+3" = "goto_tab 3";
      "map kitty_mod+4" = "goto_tab 4";
      "map kitty_mod+5" = "goto_tab 5";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
