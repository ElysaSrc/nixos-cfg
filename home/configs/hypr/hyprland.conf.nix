{ lib }:

let
  c = import ../../../lib/colors.nix { lib = lib; };
in ''
monitor=HDMI-A-2,3840x2160,1920x0,2
monitor=DP-1,1920x1080,3840x0,1
monitor=DP-2,1920x1080,0x0,1

input {
    kb_layout = fr
    follow_mouse = 1
    touchpad {
        natural_scroll = no
    }
    sensitivity = 0
}

general {
    gaps_in = 5
    gaps_out = 20
    border_size = 2
    col.active_border = rgba(${c.nohex c.purple}ee) rgba(${c.nohex c.white}ee) 45deg
    col.inactive_border = rgba(${c.nohex c.dim.white}aa)
    layout = dwindle
}

decoration {
    rounding = 5
    blur = yes
    blur_size = 3
    blur_passes = 1
    blur_new_optimizations = on

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes
    bezier = bezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, bezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    pseudotile = yes
    preserve_split = yes
}

gestures {
    workspace_swipe = off
}

$mainMod = SUPER

bind = $mainMod, Return, exec, alacritty
bind = $mainMod_SHIFT, Return, exec, firefox
bind = $mainMod, Space, exec, wofi --show drun

bind = $mainMod, Q, killactive, 
bind = $mainMod, M, exit, 
bind = $mainMod, E, exec, dolphin
bind = $mainMod, V, togglefloating, 
bind = $mainMod, F, fullscreen, 0

bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

bind = $mainMod, ampersand, workspace, 1
bind = $mainMod, eacute, workspace, 2
bind = $mainMod, quotedbl, workspace, 3
bind = $mainMod, apostrophe, workspace, 4
bind = $mainMod, parenleft, workspace, 5
bind = $mainMod, minus, workspace, 6
bind = $mainMod, egrave, workspace, 7
bind = $mainMod, underscore, workspace, 8
bind = $mainMod, ccedilla, workspace, 9
bind = $mainMod, agrave, workspace, 10

bind = $mainMod SHIFT, ampersand, movetoworkspace, 1
bind = $mainMod SHIFT, eacute, movetoworkspace, 2
bind = $mainMod SHIFT, quotedbl, movetoworkspace, 3
bind = $mainMod SHIFT, apostrophe, movetoworkspace, 4
bind = $mainMod SHIFT, parenleft, movetoworkspace, 5
bind = $mainMod SHIFT, minus, movetoworkspace, 6
bind = $mainMod SHIFT, egrave, movetoworkspace, 7
bind = $mainMod SHIFT, underscore, movetoworkspace, 8
bind = $mainMod SHIFT, ccedilla, movetoworkspace, 9
bind = $mainMod SHIFT, agrave, movetoworkspace, 10

bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow
''