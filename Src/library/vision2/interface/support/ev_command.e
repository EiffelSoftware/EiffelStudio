indexing

	description:
		"General notion of command (semantic unity). %
		%To write an actual command inherit from this %
		%class and implement the `execute' feature";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	EV_COMMAND 

feature -- Access

--	context_data: CONTEXT_DATA;
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
	
	execute_address: POINTER is
			-- Address of feature execute 
		do
			Result := routine_address($execute)
		end
	
feature {NONE} -- Help
	
	routine_address (routine: POINTER): POINTER is
		do
			Result := routine
		end
	

feature {NONE} -- Element change

-- 	set_context_data (a_context_data: CONTEXT_DATA) is
-- 			-- Set `context_data' to `a_context_data'.
-- 		do
-- 			context_data := a_context_data
-- 		ensure
-- 			context_data = a_context_data
-- 		end

end -- class EV_COMMAND


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

