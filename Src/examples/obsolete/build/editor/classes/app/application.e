indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class APPLICATION

inherit
	SHARED_CONTROL;
	STATES;
	WINDOWS

create 
	make

feature 

	make is
		do
			control.put (basic, exit_from_application, "quit")
			control.put (basic, editing, "modify")
			control.put (basic, viewing, "view")
			control.put (editing, basic, "save")
			control.put (editing, exit_from_application, "quit")
			control.put (editing, viewing, "view")
			control.put (viewing, exit_from_application, "quit")
			control.put (viewing, return_to_previous, "back")
			control.set_initial_state (basic)
			init_windowing
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


end -- class APPLICATION
