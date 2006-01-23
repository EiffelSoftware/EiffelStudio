indexing

	description: "Command to quit the application immediately"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	QUIT_NOW_COM 

inherit

	COMMAND;

	GRAPHICS
		export
			{NONE} all
		end

feature -- Basic operations

	execute (argument: ANY) is
			-- Quit the application.
		do
			exit
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




end -- class QUIT_NOW_COM

