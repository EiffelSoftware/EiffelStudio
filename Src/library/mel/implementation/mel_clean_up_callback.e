indexing

	description: 
		"Callback to clean a widget after having called other destroy callbacks"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CLEAN_UP_CALLBACK

inherit

	MEL_COMMAND
		redefine
			execute
		end

feature -- Basic operations

	execute (argument: ANY) is
			-- Clean up the object.
		do
			callback_struct.widget.clean_up
		end;

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




end -- class MEL_CLEAN_UP_CALLBACK


