indexing

	description:
		"Top level shell which is used in an application that needs %
		%more than one shell root.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TOP_SHELL_IMP

inherit

	TOP_SHELL_I;

	TOP_IMP
		rename
			make as top_shell_make,
			is_shown as shown
		undefine
			application_context
 		end
	
	SHARED_APPLICATION_CONTEXT
	
creation

	make

feature {NONE} -- Initialization

	make (a_top_shell: TOP_SHELL) is
			-- Create a motif top level shell.
		local
			x_display: MEL_DISPLAY;
		do
			widget_index := widget_manager.last_inserted_position;
			oui_top := a_top_shell;
			x_display ?= a_top_shell.screen.implementation;
			top_shell_make (a_top_shell.identifier, application_class, x_display.default_screen);
			a_top_shell.set_wm_imp (Current);
			add_protocol
		end

end -- class TOP_SHELL_IMP


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

