indexing

	description:
		"Top level shell which is used in an application that needs %
		%more than one shell root."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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
	
create

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




end -- class TOP_SHELL_IMP

