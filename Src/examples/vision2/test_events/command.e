indexing
	description: 
		"Command class of the test events example. Is executed when an%
	   % event happens."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND

inherit
	EV_COMMAND

feature -- Command execution
	
	execute (arg: EV_ARGUMENT1 [STRING]; data: EV_EVENT_DATA) is
			-- Execute command called when the event occurs.
		local
			str: STRING
		do
			str := "Event data: "
			str.append (arg.first)
			str.append ("%N")
			io.put_string (str) 
			if data /= Void then
				data.print_contents
			end
			io.put_new_line
		end

end -- class COMMAND

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

