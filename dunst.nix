{config, pkgs, ...}:

{
  services.dunst = {
    enable = true;
    settings = {
	global = {
	  format = "<b>%s</b> \\n%b";
	  origin = "top-right";
	  offset = "10x50";
	  sort = true;
	  sticky_history = true;
	  history_length = 20;
	  frame_color = "#d2e3fd";
	  separator_color = "frame";
		};

	urgency_low = {
          background = "#1e1e2e";
          foreground = "#cad3f5";
          timeout = 5;
          };

	urgency_normal = {
          background = "#1e1e2e";
          foreground = "#cad3f5";
          timeout = 10;
          };

	urgency_critical = {
          background = "#f38ba8";
          foreground = "#11111b";
          frame_color = "#eba0ac";
          timeout = 0;
           };
	};
  };

}
