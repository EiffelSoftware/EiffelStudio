indexing

	description: "Set of onces to create models of commands";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	STD_COMMANDS

feature {NONE} -- Access

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

end -- class STD_COMMANDS



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

