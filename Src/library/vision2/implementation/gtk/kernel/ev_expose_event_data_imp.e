--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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
			-- create and initialization of 'parent's 
			-- fields according to C pointer 'p'
		local
			c: EV_COORDINATES
			rec: EV_RECTANGLE
		do
			Precursor (p)			
			
			create c.set (c_gdk_event_rectangle_x (p), 
				 c_gdk_event_rectangle_y (p))

			create rec.set (c, c_gdk_event_rectangle_width (p), 
				   c_gdk_event_rectangle_height (p))
			
			set_clip_region (rec)
		end
	
end -- class EV_EXPOSE_EVENT_DATA_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

			
	

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.3  2000/01/27 19:29:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.2  2000/01/24 23:54:19  oconnor
--| renamed EV_CLIP -> EV_RECTANGLE
--|
--| Revision 1.4.6.1  1999/11/24 17:29:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
