indexing 
	description: "Command class of the hello world example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


end -- class HELLO_COMMAND

