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

end -- class STD_COMMANDS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

