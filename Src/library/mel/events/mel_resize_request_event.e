indexing

	description: 
		"Implementation of XResizeRequestEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_RESIZE_REQUEST_EVENT

inherit

	MEL_EVENT

creation
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

end -- class MEL_RESIZE_REQUEST_EVENT

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
