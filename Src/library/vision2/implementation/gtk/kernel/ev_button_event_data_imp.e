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
	
	absolute_x: INTEGER is
			-- absolute x of the mouse pointer
			-- calculated by adding `x' to the
			-- x-coord of the widget's parent window.
		do
			Result := absol_x			
		end

	absol_x: INTEGER
			-- Value used for storing absolute x.

	absolute_y: INTEGER is
			-- absolute y of the mouse pointer
			-- calculated by adding `y' to the
			-- y-coord of the widget's parent window.
		do
			Result := absol_y
		end

	absol_y: INTEGER
			-- Value used for storing absolute y.

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

			absol_x := c_gdk_event_absolute_x (p)
			absol_y := c_gdk_event_absolute_y (p)

			set_all (widget, c_gdk_event_x (p), c_gdk_event_y (p),
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

			
	
