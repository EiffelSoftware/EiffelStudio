indexing

	description: 
		"Implementation of XSelectionClearEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_CLEAR_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	time: INTEGER is
			-- Time when ownership was lost
		do
			Result := c_event_time (handle)
		end;

	selection: MEL_ATOM is
			-- Name of selection
		do
			create Result.make_from_existing (c_event_selection (handle))
		ensure
			result_non_void: Result /= Void
		end;

feature {NONE} -- Implementation

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XSelectionClearEvent *): EIF_INTEGER"
		end;

	c_event_selection (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionClearEvent *): EIF_POINTER"
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




end -- class MEL_SELECTION_CLEAR_EVENT


