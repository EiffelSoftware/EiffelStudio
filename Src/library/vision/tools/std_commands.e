indexing

	description: "Set of onces to create models of commands";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

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


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
