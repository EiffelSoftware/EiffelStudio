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
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'
		local
			c_str: POINTER
			str: STRING
			
		do
			Precursor (p)			
	--		set_state (c_gdk_event_state (p))
			set_keycode (c_gdk_event_keyval (p))
	--		set_length (c_gdk_event_length (p))
			
			c_str := c_gdk_event_string (p)
			!!str.make (0)
			str.from_c (c_str)
			set_string (str)
		end
	
end -- class EV_KEY_EVENT_DATA_IMP

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

			
	
