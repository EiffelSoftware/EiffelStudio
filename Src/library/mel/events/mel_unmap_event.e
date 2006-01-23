indexing
	description: 
		"Implementation of XUnmapEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_UNMAP_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	event_widget: MEL_WIDGET is
			-- Window that received the event
		do
			Result := retrieve_widget_from_window (event)
		end;

	from_configure: BOOLEAN is
			-- Was event generated because of parent's `win_gravity'
			-- was set to `UnmapGravity'
		do
			Result := c_event_from_configure (handle)
		end

feature -- Pointer access

	event: POINTER is
			-- Window that received the event
		do
			Result := c_event_event (event)
		end;

feature {NONE} -- Implementation

	c_event_event (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XUnmapEvent *): EIF_POINTER"
		end;

	c_event_from_configure (event_ptr: POINTER): BOOLEAN is
		external
			"C [macro %"events.h%"] (XUnmapEvent *): EIF_BOOLEAN"
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




end -- class MEL_UNMAP_EVENT


