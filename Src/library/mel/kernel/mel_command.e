indexing

	description: 
		"Implementation of the callback mechanism.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	MEL_COMMAND

feature -- Access

	callback_struct: MEL_CALLBACK_STRUCT;
			-- The callback structure is set by MEL when
			-- Current command is invoked as a callback

	is_executable (arg: ANY): BOOLEAN is
			-- Is the Current command able to be executed?
			-- (By defauult, it is True).
		do
			Result := True
		end;

feature -- Element change

	set_callback_struct (a_callback_struct: MEL_CALLBACK_STRUCT) is
			-- Set the callback structure.
		do
			callback_struct := a_callback_struct
		ensure
			set: callback_struct = a_callback_struct
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute current command.
			-- the argument is automatically passed by MEL when Current
			-- command is invoked as a callback.
		require
			is_executuable: is_executable (argument)
		deferred
		end;

end -- class MEL_COMMAND


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

