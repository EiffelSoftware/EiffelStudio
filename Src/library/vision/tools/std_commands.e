--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Set of onces to create models of commands.

class STD_COMMANDS

feature {NONE}

	draw_figure_command: DRAW_FIG_COM is
			-- Command to draw a figure or a world
		once
			!! Result
		end;

	popdown_command: POPDOWN_COM is
			-- Command to popdown a shell
		once
			!! Result
		end;

	popup_command: POPUP_COM is
			-- Command to popup a shell
		once
			!! Result
		end;

	quit_now_command: QUIT_NOW_COM is
			-- Command to quit the application incondionnally
		once
			!! Result
		end;

end
