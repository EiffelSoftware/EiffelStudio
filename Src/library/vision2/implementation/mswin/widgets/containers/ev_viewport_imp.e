--| FIXME Not for release
indexing
	description: "Eiffel Vision viewport. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_VIEWPORT_IMP
	
inherit
	EV_VIEWPORT_I
		redefine
			interface
		end
		
	EV_CELL_IMP
		redefine
			interface,
			make
		end
	
create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)

			check
				to_be_implemented: False
			end
		end	

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			check
				to_be_implemented: False
			end
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Element change

	set_x_offset (a_x: INTEGER) is
			-- Set `x_offset' to `a_x'.
		do
			check
				to_be_implemented: False
			end
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			check
				to_be_implemented: False
			end
		end

feature {NONE} -- Implementation

	interface: EV_VIEWPORT

end -- class EV_VIEWPORT_IMP

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
--| Revision 1.2  2000/02/14 12:05:10  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/01/29 01:03:13  brendel
--| Changed GTK+ to Mswindows.
--|
--| Revision 1.1.2.1  2000/01/28 19:29:01  brendel
--| Initial. New ancestor for EV_SCROLLABLE_AREA.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
