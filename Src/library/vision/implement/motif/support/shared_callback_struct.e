indexing

	description: 
		"Shared instance of the last callback structure processed."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_CALLBACK_STRUCT

feature -- Access

	last_callback_struct: MEL_CALLBACK_STRUCT is
		do	
			Result := last_callback_struct_cell.item;
		end;

feature {NONE} -- Implementation

	last_callback_struct_cell: CELL [MEL_CALLBACK_STRUCT] is
		once
		 	create Result.put (Void)
		end;

	set_last_callback_struct (an_struct: like last_callback_struct) is
		do
			last_callback_struct_cell.put (an_struct)
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




end -- class SHARED_CALLBACK_STRUCT

