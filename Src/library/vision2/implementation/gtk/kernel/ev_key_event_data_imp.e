--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision key event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_KEY_EVENT_DATA_IMP
	
inherit
	EV_KEY_EVENT_DATA_I
	
	EV_EVENT_DATA_IMP
		redefine
			initialize
		end

feature -- Initialization
	
	initialize (p: POINTER) is
			-- create and initialization of 'parent's 
			-- fields according to C pointer 'p'
		local
			c_str: POINTER
			str: STRING
			keycod, gtk_state: INTEGER
			-- gtk_state is the `state' value given by GTK fonction
			shift, control, caps_lock, num_lock, scroll_lock: BOOLEAN
		do
			Precursor (p)
--			set_length (c_gdk_event_length (p))

			keycod:= c_gdk_event_keyval (p)
			gtk_state:= c_gtk_event_keys_state (p)
			c_str := c_gdk_event_string (p)
			create str.make (0)

			if c_str/= default_pointer then
				str.from_c (c_str)
			end

			shift:= bit_set (gtk_state, 1)
			control:= bit_set (gtk_state, 4)
			caps_lock:= bit_set (gtk_state, 2)
			num_lock:= bit_set (gtk_state, 32)
			scroll_lock:= False

			set_all (widget, keycod, str, shift, control,
					caps_lock, num_lock, scroll_lock)

		end

end -- class EV_KEY_EVENT_DATA_IMP

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
--| Revision 1.6  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.2  2000/01/27 19:29:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.1  1999/11/24 17:29:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
