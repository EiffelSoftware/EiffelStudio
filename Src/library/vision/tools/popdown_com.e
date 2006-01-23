indexing

	description: "Command to popdown a shell"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	POPDOWN_COM 

inherit

	COMMAND

feature -- Basic operations

	execute (argument: ANY) is
			-- Popdown a shell.
		local
			shell: POPUP_SHELL;
			dialog: DIALOG
		do
			shell ?= argument;
			if (shell = Void) then
				dialog ?= argument;
				dialog.popdown;
			else
				shell.popdown;
			end
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




end -- class POPDOWN_COM

