indexing

	description: 
		"Callback to quit the application immediately.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_QUIT_NOW_CALLBACK

inherit

	MEL_CALLBACK
		redefine
			execute
		end

creation

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

end -- class MEL_QUIT_NOW_CALLBACK

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
