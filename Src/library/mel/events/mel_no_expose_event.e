indexing

	description: 
		"Implementation of XNoExposeEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_NO_EXPOSE_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	drawable: POINTER is
			-- Destination of copy operation
		do
			Result := c_event_drawable (handle)
		end;

	major_code: INTEGER is
			-- Major code
		do
			Result := c_event_major_code (handle)
		end;

	minor_code: INTEGER is
			-- Minor code
		do
			Result := c_event_minor_code (handle)
		end;

feature {NONE} -- Implementation

	c_event_drawable (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XNoExposeEvent *): EIF_POINTER"
		end;

	c_event_major_code (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XNoExposeEvent *): EIF_INTEGER"
		end;

	c_event_minor_code (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XNoExposeEvent *): EIF_INTEGER"
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




end -- class MEL_NO_EXPOSE_EVENT


