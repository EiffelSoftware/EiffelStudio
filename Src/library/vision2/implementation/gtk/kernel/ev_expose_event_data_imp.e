indexing
	description: "EiffelVision expose event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_EXPOSE_EVENT_DATA_IMP
	
inherit
	EV_EXPOSE_EVENT_DATA_I
	
	EV_EVENT_DATA_IMP
		redefine
			initialize
		end

feature -- Initialization
	
		initialize (p: POINTER) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'
		local
			c: EV_POINT
			rec: EV_RECTANGLE
		do
			Precursor (p)			
			
			!!c.set (c_gdk_event_rectangle_x (p), 
				 c_gdk_event_rectangle_y (p))

			!!rec.set (c, c_gdk_event_rectangle_width (p), 
				   c_gdk_event_rectangle_height (p))
			
			set_clip_region (rec)
		end
	
end -- class EV_EXPOSE_EVENT_DATA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

			
	
