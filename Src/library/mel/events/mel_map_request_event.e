indexing

	description: 
		"Implementation of XMapRequestEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_MAP_REQUEST_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	parent_widget: MEL_WIDGET is
			-- Parent widget of `window'
		do
			Result := retrieve_widget_from_window (parent)
		end;

feature -- Pointer access

	parent: POINTER is
			-- Parent window of `window'.
		do
			Result := c_event_parent (handle)
		end;

feature {NONE} -- Implementation

	c_event_parent (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XMapRequestEvent *): EIF_POINTER"
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




end -- class MEL_MAP_REQUEST_EVENT


