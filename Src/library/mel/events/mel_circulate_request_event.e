indexing

	description: 
		"Implementation of XCirculateRequestEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CIRCULATE_REQUEST_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	parent_widget: MEL_WIDGET is
			-- Parent window pointer that was restacked
		do
			Result := retrieve_widget_from_window (parent)
		end;

    is_place_on_top: BOOLEAN is
            -- Is the window place on top?
        do
            Result := c_event_place (handle) = PlaceOnTop
        ensure
            valid_result: Result = not is_place_on_bottom
        end;

    is_place_on_bottom: BOOLEAN is
            -- Is the window place on the bottom?
        do
            Result := c_event_place (handle) = PlaceOnBottom
        ensure
            valid_result: Result = not is_place_on_top
        end;

feature -- Pointer access

	parent: POINTER is
			-- Parent window pointer that was restacked
		do
			Result := c_event_parent (handle)
		end;

feature {NONE} -- Implementation

	c_event_parent (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XCirculateRequestEvent *): EIF_POINTER"
		end;

	c_event_place (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XCirculateRequestEvent *): EIF_INTEGER"
		end;

end -- class MEL_CIRCULATE_REQUEST_EVENT

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
