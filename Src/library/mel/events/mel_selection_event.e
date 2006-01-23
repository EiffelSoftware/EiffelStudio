indexing

	description: 
		"Implementation of XSelectionEvent."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_EVENT

inherit

	MEL_EVENT

create
	make

feature -- Access

	time: INTEGER is
			-- Time when data was stored
		do
			Result := c_event_time (handle)
		end;

	requestor_widget: MEL_WIDGET is
			-- Widget requesting information
		do
			Result := retrieve_widget_from_window (requestor)
		end

	selection: MEL_ATOM is
			-- Name of selection
		do
			create Result.make_from_existing (c_event_selection (handle))	
		ensure
			result_non_void: Result /= Void
		end;

	target: MEL_ATOM is
			-- Data type of value in `property'
		local
			p: POINTER
		do
			p := c_event_target (handle);
			if p /= Void then
				create Result.make_from_existing (p)
			end
		end;

	property: MEL_ATOM is
			-- Property where data has been place
		local
			p: POINTER
		do
			p := c_event_property (handle);
			if p /= Void then
				create Result.make_from_existing (p)
			end
		end;

feature -- Pointer access

	requestor: POINTER is
			-- Window requesting information
		do
			Result := c_event_requestor (handle)
		end;

feature {NONE} -- Implementation

	c_event_requestor (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_POINTER"
		end;

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_INTEGER"
		end;

	c_event_selection (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_POINTER"
		end;

	c_event_target (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_POINTER"
		end;

	c_event_property (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionEvent *): EIF_POINTER"
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




end -- class MEL_SELECTION_EVENT


