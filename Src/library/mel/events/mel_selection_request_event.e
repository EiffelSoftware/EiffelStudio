indexing

	description: 
		"Implementation of XSelectionRequestEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_REQUEST_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

    time: INTEGER is
            -- Time when selection was requested
        do
            Result := c_event_time (handle)
        end;

    requestor_widget: MEL_WIDGET is
			-- Widget that received data
        do
            Result := retrieve_widget_from_window (requestor)
        end

    owner_widget: MEL_WIDGET is
			-- Widget that owns the selection
        do
            Result := retrieve_widget_from_window (owner)
        end

    selection: MEL_ATOM is
			-- Name of selection
        do
            !! Result.make_from_existing (c_event_selection (handle))
		ensure
			result_non_void: Result /= Void
        end;

    target: MEL_ATOM is
			-- Data should be converted to this type by the owner
        do
            !! Result.make_from_existing (c_event_target (handle))
		ensure
			result_non_void: Result /= Void
        end;

    property: MEL_ATOM is
			-- Selection's owner should copy data to this property
        do
			!! Result.make_from_existing (c_event_property (handle))
		ensure
			result_non_void: Result /= Void
        end;

feature -- Pointer access

	owner: POINTER is
			-- Window that owns the selection
        do
            Result := c_event_owner (handle)
        end;

    requestor: POINTER is
			-- Window that received data
        do
            Result := c_event_requestor (handle)
        end;

feature {NONE} -- Implementation

	c_event_owner (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionRequestEvent *): EIF_POINTER"
		end;

	c_event_requestor (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionRequestEvent *): EIF_POINTER"
		end;

	c_event_time (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XSelectionRequestEvent *): EIF_INTEGER"
		end;

	c_event_selection (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionRequestEvent *): EIF_POINTER"
		end;

	c_event_target (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionRequestEvent *): EIF_POINTER"
		end;

	c_event_property (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XSelectionRequestEvent *): EIF_POINTER"
		end;

end -- class MEL_SELECTION_REQUEST_EVENT

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
