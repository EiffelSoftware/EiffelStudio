indexing
	description: "EiffelVision menu. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_IMP
	
inherit
	EV_MENU_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			destroy
		redefine
			interface,
			make,
			initialize
		end

	EV_MENU_ITEM_LIST_IMP
		undefine
			pnd_press,
			check_drag_and_drop_release
		redefine
			interface,
			make,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
			{EV_MENU_ITEM_IMP} Precursor (an_interface)
			create ev_children.make (2)
			make_track
			make_id
		end

	initialize is
		do
			{EV_MENU_ITEM_IMP} Precursor
			{EV_MENU_ITEM_LIST_IMP} Precursor
		end

feature -- Basic operations

	show is
			-- Pop up on the current pointer position.
		local
			wel_point: WEL_POINT
		do
			if count > 0 then
				create wel_point.make (0, 0)
				wel_point.set_cursor_position
				show_track (wel_point.x, wel_point.y,
					create {EV_POPUP_MENU_HANDLER}.make_with_menu (Current))
			end
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		local
			wel_point: WEL_POINT
			wel_win: WEL_WINDOW
		do
			if count > 0 then
				create wel_point.make (a_x, a_y)
				wel_win ?= a_widget.implementation
				if wel_win /= Void then
					create wel_point.make (a_x, a_y)
					wel_point.client_to_screen (wel_win)
				else
					create wel_point.make (0, 0)
				end
				show_track (wel_point.x, wel_point.y,
					create {EV_POPUP_MENU_HANDLER}.make_with_menu (Current))
			end
		end

feature {NONE} -- Implementation

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
		-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
		do
			--| FIXME To be implemented for pick-and-dropable.
			check
				to_be_implemented: False
			end
		end

	client_to_screen (a_x, a_y: INTEGER): WEL_POINT is
			-- `Result' is absolute screen coordinates in pixels
			-- of coordinates `a_x', a_y_' on `Current'.
		do
			--| FIXME To be implemented for pick-and-dropable.
			check
				to_be_implemented: False
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU	

end -- class EV_MENU_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.22  2000/04/27 23:12:49  rogers
--| Undefined check_drag_and_drop_Release from EV_MENU_ITEM_LIST_IMP.
--|
--| Revision 1.21  2000/04/11 19:02:16  brendel
--| Improved FIXME's and Copyright notice.
--|
--| Revision 1.20  2000/04/11 16:53:09  rogers
--| Added internal_propagate_pointer_press and client_to_screen.
--|
--| Revision 1.19  2000/04/10 16:27:57  brendel
--| Modified creation sequence.
--|
--| Revision 1.18  2000/03/23 01:06:15  brendel
--| Implemented show and show-at.
--|
--| Revision 1.17  2000/03/22 22:51:08  brendel
--| Added show and show_at. Do not work yet.
--|
--| Revision 1.16  2000/02/24 01:39:48  brendel
--| Added undefine of the parent from the interface.
--|
--| Revision 1.15  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.14  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.10.6  2000/02/05 02:26:29  brendel
--| Revised.
--| Implemented using EV_MENU_ITEM and EV_MENU_ITEM_LIST.
--|
--| Revision 1.13.10.5  2000/02/04 01:05:41  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.13.10.4  2000/02/03 17:16:59  brendel
--| Commented out old vision related implementation. Needs implementing.
--|
--| Revision 1.13.10.3  2000/01/27 19:30:31  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.10.2  1999/12/17 00:21:00  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--|
--| Revision 1.13.10.1  1999/11/24 17:30:36  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.6.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
