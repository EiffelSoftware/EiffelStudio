indexing

	description: "Set of onces to create models of commands"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	STD_COMMANDS

feature {NONE} -- Access

	draw_figure_command: DRAW_FIG_COM is
			-- Command to draw a figure or a world
		once
			create Result
		end;

	popdown_command: POPDOWN_COM is
			-- Command to popdown a shell
		once
			create Result
		end;

	popup_command: POPUP_COM is
			-- Command to popup a shell
		once
			create Result
		end;

	quit_now_command: QUIT_NOW_COM is
			-- Command to quit the application incondionnally
		once
			create Result
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class STD_COMMANDS

