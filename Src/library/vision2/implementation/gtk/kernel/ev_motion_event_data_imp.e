--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision motion event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MOTION_EVENT_DATA_IMP
	
inherit
	EV_MOTION_EVENT_DATA_I
		
	EV_EVENT_DATA_IMP
		redefine
			initialize
		end

feature -- Initialization
	
	initialize (p: POINTER) is
			-- create and initialization of 'parent's 
			-- fields according to C pointer 'p'
		local
			shift, control, first, second, third: BOOLEAN
			gtk_state: INTEGER
			-- value of `state' given by GTK fonction
		do
			Precursor (p)			

			gtk_state:= c_gtk_event_keys_state(p)
			shift:= bit_set (gtk_state, 1)
			control:= bit_set (gtk_state, 4)
			first:= bit_set (gtk_state, 256)
			second:= bit_set (gtk_state, 512)
			third:= bit_set (gtk_state, 1024)

			absol_x := c_gdk_event_absolute_x (p)
			absol_y := c_gdk_event_absolute_y (p)

			set_all ( widget, c_gdk_event_x (p), c_gdk_event_y (p),
					shift, control, first, second, third)
		end

feature -- Access	
	
	absolute_x: INTEGER is
			-- absolute x of the mouse pointer
		do
			Result := absol_x
		end

	absol_x: INTEGER
			-- value for storing absolute x.

	absolute_y: INTEGER is
			-- absolute y of the mouse pointer
		do
			Result := absol_y
		end

	absol_y: INTEGER
			-- value for storing absolute y.

end -- class EV_MOTION_EVENT_DATA_IMP

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
--| Revision 1.9  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.4.1.2.2  2000/01/27 19:29:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.4.1.2.1  1999/11/24 17:29:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
