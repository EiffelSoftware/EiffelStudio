indexing

	description: 
		"Implementation of XResizeRequestEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_RESIZE_REQUEST_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	width: INTEGER is
			-- New width of `window'
		do
			Result := c_event_width (handle)
		end

	height: INTEGER is
			-- New height of `window'
		do
			Result := c_event_height (handle)
		end;

feature {NONE} -- Implementation

	c_event_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XResizeRequestEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XResizeRequestEvent *): EIF_INTEGER"
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




end -- class MEL_RESIZE_REQUEST_EVENT


