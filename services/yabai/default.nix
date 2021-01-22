{ pkgs, ... }:

let padding = 10;
in {
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      # mouse_follows_focus = "on";
      # focus_follows_mouse = "autoraise";
      window_shadow = "off";
      window_placement = "second_child";
      # window_border = "on";
      # window_border_width = 5;
      # active_window_border_color = "0xffa35763";
      # normal_window_border_color = "0xff353c54";
      # insert_feedback_color = "0xaa7c5c9c";
      auto_balance = "off";
      split_ratio = 0.50;
      window_gap = 7;
      layout = "bsp";
      top_padding = 35;
      bottom_padding = padding;
      left_padding = padding;
      right_padding = padding;
    };
    extraConfig = ''
      # mission-control desktop labels
      yabai -m space 1 --label web
      yabai -m space 2 --label code
      yabai -m space 3 --label social
      yabai -m space 4 --label mail
      yabai -m space 5 --label media

      # window rules
      yabai -m rule --add app="^Firefox$" space=web
      yabai -m rule --add app="^Emacs$" space=code manage=on
      yabai -m rule --add app="^Telegram$" space=social
      yabai -m rule --add app="^Slack$" space=social
      yabai -m rule --add app="^Discord$" space=social
      yabai -m rule --add app="^Spark$" space=mail manage=off
      yabai -m rule --add app="^Transmission$" space=media
      yabai -m rule --add app="^Spotify$" space=media manage=on
      yabai -m rule --add app="^mpv$" space=media manage=on
      yabai -m rule --add app="^Finder$" title="(Co(py|nnect)|Move|Info|Pref)" manage=off
      yabai -m rule --add app="^Spotlight$" layer=above manage=off
      yabai -m rule --add app="^Stickies$" manage=off
      yabai -m rule --add app="^System Preferences$" layer=above manage=off

      # signals
      yabai -m signal --add event=window_destroyed action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"
      yabai -m signal --add event=application_terminated action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus mouse"

      # simple-bar
      # Refresh spaces widget on space change
      yabai -m signal --add event=space_changed action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-spaces-jsx\"'"
      # Refresh spaces widget on display focus change
      yabai -m signal --add event=display_changed action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-spaces-jsx\"'"
      # Refresh process widget on space change
      yabai -m signal --add event=space_changed action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-process-jsx\"'"

      # Refresh process widget on when focused application changes
      yabai -m signal --add event=window_focused action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-process-jsx\"'"
      # Refresh spaces widget on when focused application changes
      yabai -m signal --add event=window_focused action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-spaces-jsx\"'"

      # Refresh process widget on when focused application changes
      yabai -m signal --add event=application_front_switched action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-process-jsx\"'"
      # Refresh spaces widget on when focused application changes
      yabai -m signal --add event=application_front_switched action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-spaces-jsx\"'"

      # Refresh process widget on when an application window is closed
      yabai -m signal --add event=window_destroyed action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-process-jsx\"'"
      # Refresh spaces widget on when an application window is closed
      yabai -m signal --add event=window_destroyed action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-spaces-jsx\"'"

      # Refresh process widget when current window title changes
      yabai -m signal --add event=window_title_changed action="osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-process-jsx\"'"
    '';
  };
}
