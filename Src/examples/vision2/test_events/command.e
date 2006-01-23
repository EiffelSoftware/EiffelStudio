indexing
	description: 
		"Command class of the test events example. Is executed when an%
	   % event happens."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


end -- class COMMAND

