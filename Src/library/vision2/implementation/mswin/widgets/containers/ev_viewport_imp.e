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
			interface,
			set_offset
		end
		
	EV_CELL_IMP
		undefine
			default_style,
			default_ex_style
		redefine
			interface,
			make,
			on_size,
			ev_apply_new_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)
			wel_make (Default_parent, "")
		end	

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			if item /= Void then
				Result := - item.x_position
			end
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			if item /= Void then
				Result := - item.y_position
			end
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Set `x_offset' to `an_x'.
		do
			if item /= Void then
				item_imp.ev_move (- an_x, item.y_position)
			end
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			if item /= Void then
				item_imp.ev_move (item.x_position, - a_y)
			end
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		do
			if item /= Void then
				item_imp.ev_move (- an_x, - a_y)
			end
		end

feature {EV_ANY_I} -- Implementation

	compute_minimum_width, compute_minimum_height, compute_minimum_size is
			-- Recompute both minimum_width and minimum_height of `Current'.
			-- Does nothing since it does not have a sense to compute it,
			-- it is only what the user set it to.
		do
			ev_set_minimum_size (child_cell.minimum_width, child_cell.minimum_height)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		do
			Result := Ws_child + Ws_clipchildren + Ws_clipsiblings + Ws_visible
		end

	default_ex_style: INTEGER is
			-- The default ex-style of the window.
		do
			Result := Ws_ex_controlparent
		end

	on_size (size_type, a_width, a_height: INTEGER) is
		do
			if size_type /= Wel_window_constants.Size_minimized then
				interface.resize_actions.call (
					[screen_x, screen_y, a_width, a_height]
				)
				if item /= Void then
					on_size_requested (True)
				end
			end
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize
				(a_x_position, a_y_position, a_width, a_height, repaint)
			if item_imp /= Void then
				on_size_requested (False)
			end
		end

	on_size_requested (originator: BOOLEAN) is
			-- Size has changed.
		require
			item_not_void: item /= Void
		local
			imp: like item_imp
		do
			imp := item_imp
			if originator then
				imp.set_move_and_size (imp.x_position, imp.y_position, 
					imp.width, imp.height)
			else
				imp.ev_apply_new_size (imp.x_position ,imp.y_position,
					imp.width, imp.height, True)			
			end
		end

	interface: EV_VIEWPORT

end -- class EV_VIEWPORT_IMP

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.16  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.12.2.13  2001/03/04 01:49:35  manus
--| `compute_minimum_xxx' only sets the minimum_xxx to the one previously computed
--| since no once can change this value but the user itself.
--|
--| Revision 1.12.2.12  2001/01/30 19:56:04  rogers
--| Ev_apply_new_size now resizes `Current'. On_size_requested is also only
--| called if item_imp /= Void.
--|
--| Revision 1.12.2.11  2001/01/30 19:26:45  manus
--| Fixed the non-implemented `ev_apply_new_size' feature so that it calls
--| `on_size_requested' with a new arguments telling the origin of the call
--|  (which is either a user resize event or an internal one due to vision2 code).
--|
--| Revision 1.12.2.10  2001/01/02 22:13:32  rogers
--| Removed unused locals from on_size_requested.
--|
--| Revision 1.12.2.9  2000/12/27 19:58:24  rogers
--| Removed redefinition of set_default_minimum_size. Default minimum is now 0,0.
--|
--| Revision 1.12.2.8  2000/12/22 19:03:48  rogers
--| On_size_requested no longer re-sizes `item' if `item' is smaller than
--| `Current'.
--|
--| Revision 1.12.2.7  2000/10/09 05:03:04  manus
--| Removed `Ws_ex_clientedge' style since if we want a special border we can put it in a frame.
--|
--| Revision 1.12.2.6  2000/08/08 16:06:51  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| No need to inherit from WEL_CONTROL_WINDOW.
--|
--| Revision 1.12.2.5  2000/07/12 16:23:00  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.12.2.4  2000/06/09 20:56:02  manus
--| Cosmetics for CVS
--|
--| Revision 1.12.2.3  2000/05/03 22:35:03  brendel
--| Fixed resize_actions.
--|
--| Revision 1.12.2.2  2000/05/03 22:16:28  pichery
--| - Cosmetics / Optimization with local variables
--| - Replaced calls to `width' to calls to `wel_width'
--|   and same for `height'.
--|
--|
--| Revision 1.12.2.1  2000/05/03 19:09:46  oconnor
--| mergred from HEAD
--|
--| Revision 1.12  2000/04/26 21:01:29  brendel
--| child -> item or item_imp.
--|
--| Revision 1.11  2000/04/24 16:02:16  brendel
--| Added redefinition of set_offset, to move x and y at the same time.
--|
--| Revision 1.10  2000/04/22 01:24:23  brendel
--| Improved wel_move_and_resize.
--|
--| Revision 1.9  2000/04/21 22:35:58  brendel
--| Improved implementation.
--|
--| Revision 1.8  2000/04/21 22:03:23  brendel
--| Implemented offset functions.
--|
--| Revision 1.7  2000/04/21 00:49:24  brendel
--| Scrollbars are not shown anymore.
--|
--| Revision 1.6  2000/03/29 21:28:45  brendel
--| Fixed compiler errors resulting from recent changes.
--|
--| Revision 1.5  2000/03/09 01:18:40  brendel
--| Useable, but features are not implemented yet.
--| Scrollbars (dis)appear dynamically at the moment.
--|
--| Revision 1.4  2000/02/22 18:39:46  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.3  2000/02/19 05:45:01  oconnor
--| released
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
