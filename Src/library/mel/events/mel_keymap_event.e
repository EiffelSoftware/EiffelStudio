indexing

	description: 
		"Implementation of XKeymapEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_KEYMAP_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Pointer access

	key_vector: POINTER is
			-- Key vector pointer
		do
			Result := c_event_key_vector (handle)
		end

feature {NONE} -- Implementation

	c_event_key_vector (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XKeymapEvent *): EIF_POINTER"
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




end -- class MEL_KEYMAP_EVENT


