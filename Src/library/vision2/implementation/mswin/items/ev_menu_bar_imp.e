indexing
	description: "Eiffel Vision menu bar. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_MENU_BAR_IMP

inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the menu bar.
		do
			Precursor (an_interface)
			wel_make
		end

feature {NONE} -- Implementation

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
		-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
		do
			--|FIXME Implement
			check
				False
			end
		end

	set_pointer_style (value: EV_CURSOR) is
			-- Make `value' the new cursor of the widget
		do
			--|FIXME Implement
			check
				False
			end
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
			--|FIXME Implement
			check
				False
			end
		end

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
		do
			--|FIXME Implement
			check
				False
			end
		end

	set_heavy_capture is
		do
			--|FIXME Implement
			check
				False
			end
		end

	release_heavy_capture is
		do
			--|FIXME Implement
			check
				False
			end
		end

	set_capture is
		do
			--|FIXME Implement
			check
				False
			end
		end

	release_capture is
		do
			--|FIXME Implement
			check
				False
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR

end -- class EV_MENU_BAR_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/04/11 16:55:15  rogers
--| Added features required by EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--|
--| Revision 1.8  2000/04/10 16:27:57  brendel
--| Modified creation sequence.
--|
--| Revision 1.7  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.6  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.10.4  2000/02/05 02:25:37  brendel
--| Revised.
--| Implemented using newly created EV_MENU_ITEM_LIST.
--|
--| Revision 1.5.10.3  2000/02/04 01:05:41  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.5.10.2  2000/01/27 19:30:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.10.1  1999/11/24 17:30:36  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
