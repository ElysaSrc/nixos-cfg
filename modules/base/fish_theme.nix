{ lib }:

let
  c = import ../../lib/colors.nix { lib = lib; };
in ''
  # Color codes
  set -l foreground ${c.nohex c.white}
  set -l selection ${c.nohex c.background.variant}
  set -l comment ${c.nohex c.bright.purple}
  set -l red ${c.nohex c.bright.red}
  set -l orange ${c.nohex c.orange}
  set -l yellow ${c.nohex c.yellow}
  set -l green ${c.nohex c.green}
  set -l purple ${c.nohex c.purple}
  set -l cyan ${c.nohex c.aqua}
  set -l blue ${c.nohex c.blue}

  # Syntax Highlighting Colors
  set -g fish_color_normal $foreground
  set -g fish_color_command $cyan
  set -g fish_color_keyword $blue
  set -g fish_color_quote $yellow
  set -g fish_color_redirection $foreground
  set -g fish_color_end $orange
  set -g fish_color_error $red
  set -g fish_color_param $purple
  set -g fish_color_comment $comment
  set -g fish_color_selection --background=$selection
  set -g fish_color_search_match --background=$selection
  set -g fish_color_operator $green
  set -g fish_color_escape $blue
  set -g fish_color_autosuggestion $comment

  # Completion Pager Colors
  set -g fish_pager_color_progress $comment
  set -g fish_pager_color_prefix $cyan
  set -g fish_pager_color_completion $foreground
  set -g fish_pager_color_description $comment
''
