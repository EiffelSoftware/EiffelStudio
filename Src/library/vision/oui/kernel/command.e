indexing

	description:
		"General notion of command (semantic unity). %
		%To write an actual command inherit from this %
		%class and implement the `execute' feature";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	COMMAND 

feature -- Access

	context_data: CONTEXT_DATA;
			-- Information related to Current command,
			-- provided by the underlying user interface 
			-- mechanism

feature -- Status report

	is_template: BOOLEAN is
			-- Is the current command a template, in other words,
			-- should it be cloned before execution?
			-- If true, EiffelVision will clone Current command 
			-- whenever it is invoked as a callback
		do
		end;

	context_data_useful: BOOLEAN is
			-- Should the context data be available
			-- when Current command is invoked as a
			-- callback
		do
		end;

feature -- Basic operations

	execute (argument: ANY) is
			-- Execute Current command.
			-- `argument' is automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
		deferred
		end;

feature {EVENT_HDL} -- Element change

	set_context_data (a_context_data: CONTEXT_DATA) is
			-- Set `context_data' to `a_context_data'.
		do
			context_data := a_context_data
		ensure
			context_data = a_context_data
		end

end -- class COMMAND

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

