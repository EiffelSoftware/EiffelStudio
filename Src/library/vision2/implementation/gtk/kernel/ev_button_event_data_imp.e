--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision button event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_BUTTON_EVENT_DATA_IMP
	
inherit
	EV_BUTTON_EVENT_DATA_I
	
	EV_EVENT_DATA_IMP
		redefine
			initialize
		end

feature -- Access	
	
	absolute_x: INTEGER
			-- absolute x of the mouse pointer
			-- calculated by adding `x' to the
			-- x-coord of the widget's parent window.

	absolute_y: INTEGER
			-- absolute y of the mouse pointer
			-- calculated by adding `y' to the
			-- y-coord of the widget's parent window.

feature -- Initialization
	
		initialize (p: POINTER) is
			-- create and initialization of 'parent's 
			-- fields according to C pointer 'p'
		local
			gtk_state: INTEGER
				-- value of `state' given by GTK function
			shift, control, first, second, third: BOOLEAN
		do
			Precursor (p)			

			gtk_state:= c_gtk_event_keys_state(p)
			shift:= bit_set (gtk_state, 1)
			control:= bit_set (gtk_state, 4)
			first:= bit_set (gtk_state, 256)
			second:= bit_set (gtk_state, 512)
			third:= bit_set (gtk_state, 1024)

			absolute_x := c_gdk_event_absolute_x (p)
			absolute_y := c_gdk_event_absolute_y (p)

			set_all (source, c_gdk_event_x (p), c_gdk_event_y (p),
					c_gdk_event_button (p), shift,
					control, first, second, third)
		end

end -- class EV_BUTTON_EVENT_DATA_IMP

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
--| Revision 1.11  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.2.1.2.3  2000/01/27 19:29:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.2.1.2.2  1999/12/09 01:40:07  oconnor
--| king: rename absol_x|y -> absolute_x|y
--|
--| Revision 1.9.2.1.2.1  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
