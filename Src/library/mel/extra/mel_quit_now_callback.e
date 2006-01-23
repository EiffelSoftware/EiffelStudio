indexing

	description: 
		"Callback to quit the application immediately."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_QUIT_NOW_CALLBACK

inherit

	MEL_COMMAND
		redefine
			execute
		end

create

	make

feature {NONE} -- Initialization

	make (app_cont: like application_context) is
			-- Initialize command.
		require
			valid_app_cont: app_cont /= Void
		do
			application_context := app_cont
		end;

feature -- Access

	application_context: MEL_APPLICATION_CONTEXT
			-- Application context

feature -- Execution

	execute (arg: ANY) is
			-- Quit the application.
		do
			application_context.exit
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




end -- class MEL_QUIT_NOW_CALLBACK


