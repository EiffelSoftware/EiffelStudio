indexing 
	description: "Command class of the hello world example."
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

class
	HELLO_COMMAND

inherit
	EV_COMMAND

feature -- Command execution

	execute (arg: EV_ARGUMENT1[STRING]; data: EV_EVENT_DATA) is
			-- Execute command called when the event occurs.
		do
			io.put_string ("Button: '")
			io.put_string (arg.first)
			io.put_string ("' pressed%N")
		end

end -- class HELLO_COMMAND

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

