indexing

	description:
		"General notion of command (semantic unity). %
		%To write an actual command inherit from this %
		%class and implement the `execute' feature"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	EV_COMMAND 

feature -- Basic operations

	execute (args: EV_ARGUMENTS; data: EV_EVENT_DATA) is
			-- Execute Current command.
			-- `args' and `data' are automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
		deferred
		end

	execute_address: POINTER is
			-- Address of feature execute 
		do
			Result := routine_address($execute)
		end
	
feature {NONE} -- Implementation
	
	routine_address (routine: POINTER): POINTER is
		do
			Result := routine
		end

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

