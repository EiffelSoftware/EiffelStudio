indexing

	description: 
		"Implementation of the XGraphicsExposeEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GRAPHICS_EXPOSE_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	x: INTEGER is
			-- X position of exposed area
		do
			Result := c_event_x (handle)
		end;

	y: INTEGER is
			-- Y position of exposed area
		do
			Result := c_event_y (handle)
		end;

	width: INTEGER is
			-- Width of exposed area
		do
			Result := c_event_width (handle)
		end;

	height: INTEGER is
			-- Height of exposed area
		do
			Result := c_event_height (handle)
		end;

	count: INTEGER is
			-- Number of expose events to come
		do
			Result := c_event_count (handle)
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

feature -- Pointer access

	drawable: POINTER is
			-- Destintation of copy operation
		do
			Result := c_event_drawable (handle)
		end

feature {NONE} -- Implementation

	c_event_drawable (event_ptr: POINTER): POINTEr is
		external
			"C [macro %"events.h%"] (XGraphicsExposeEvent *): EIF_POINTER"
		end;

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGraphicsExposeEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGraphicsExposeEvent *): EIF_INTEGER"
		end;

	c_event_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGraphicsExposeEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGraphicsExposeEvent *): EIF_INTEGER"
		end;

	c_event_count (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGraphicsExposeEvent *): EIF_INTEGER"
		end;

	c_event_major_code (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGraphicsExposeEvent *): EIF_INTEGER"
		end;

	c_event_minor_code (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XGraphicsExposeEvent *): EIF_INTEGER"
		end;

end -- class MEL_GRAPHICS_EXPOSE_EVENT

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
