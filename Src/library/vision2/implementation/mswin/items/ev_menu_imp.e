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
		redefine
			interface,
			make,
			initialize,
			has_parent,
			disable_sensitive,
			enable_sensitive,
			wel_set_text
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
			-- Create `Current' with interface `an_interface'.
		do
			Precursor {EV_MENU_ITEM_IMP} (an_interface)
			create ev_children.make (2)
			make_track
			make_id
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_MENU_ITEM_IMP}
			Precursor {EV_MENU_ITEM_LIST_IMP}
		end

feature {EV_ANY_I} -- Basic operations

	disable_sensitive is
   			-- Set `Current' insensitive.
   		local
   			menu_bar_imp: EV_MENU_BAR_IMP
		do
			is_sensitive := False
			set_insensitive (True)
			if has_parent then
				parent_imp.disable_position (parent_imp.index_of (interface, 1) - 1)
					--| Only disabling the position is not enough if we are parented in
					--| a menu bar (i.e. always visible on the window). We must call
					--| `draw_menu' on the window for the visual appearence of `Current' to
					--| be updated immediately.
				menu_bar_imp ?= parent_imp
				if menu_bar_imp /= Void then
					if menu_bar_imp.parent_imp /= Void then
						menu_bar_imp.parent_imp.draw_menu
					end
				end
			end
   		end

	enable_sensitive is
			-- Set `Current' insensitive.
		local
   			menu_bar_imp: EV_MENU_BAR_IMP
		do
			is_sensitive := True
			set_insensitive (False)
			if has_parent then
				parent_imp.enable_position (parent_imp.index_of (interface, 1) - 1)
					--| Only enabling the position is not enough if we are parented in
					--| a menu bar (i.e. always visible on the window). We must call
					--| `draw_menu' on the window for the visual appearence of `Current' to
					--| be updated immediately.
				menu_bar_imp ?= parent_imp
				if menu_bar_imp /= Void then
					if menu_bar_imp.parent_imp /= Void then
						menu_bar_imp.parent_imp.draw_menu
					end
				end
			end
		end

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

	set_insensitive (flag: BOOLEAN) is
			-- If `flag' then make children of `Current' insensitive else
			-- make children sensitive.
		local
			list: ARRAYED_LIST [EV_MENU_ITEM_IMP]
			child_imp: EV_MENU_ITEM_IMP
			cur: CURSOR
		do
			if not ev_children.is_empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					child_imp := list.item
					if flag then
						child_imp.disable_sensitive
					else
						if not child_imp.internal_non_sensitive then
							child_imp.enable_sensitive
						end
					end
					list.forth
				end
				list.go_to (cur)
			end
		ensure
			cursor_not_moved: old ev_children.index = ev_children.index
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

	update_parent_size is
			-- Update size of parent
		do
			--| No need to do anything here. Deferred from EV_MENU_ITEM_LIST_IMP.
		end

	wel_set_text (a_text: STRING) is
			-- Assign `a_text' to `Current' and refresh `Current'.
		local
			wel_string: WEL_STRING
			pos: INTEGER
		do
			real_text := clone (a_text)
			if has_parent then
				create wel_string.make (real_text)
					-- Retrieve the index of `Current'.
				pos := parent_imp.interface.index_of (interface, 1)
					-- Modify `Current'.
				cwin_modify_menu (parent_imp.wel_item, pos - 1, Mf_Byposition +
					Mf_String + Mf_popup, to_integer, wel_string.item)
					-- Re-draw the menu bar.
				cwin_draw_menu_bar (top_level_window_imp.wel_item)
			end
		end

	has_parent: BOOLEAN is
			-- Is `Current' parented?
		do
			Result := parent_imp /= Void
		end

	disable_default_processing is
			-- Disable default window processing.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on a pointer press.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item event.
			-- Called on a pointer double press.
		do
			--| FIXME To be implemented for pick-and-dropable.
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_MENU_ITEM_IMP is
			-- `Result' is menu_item at pixel position `x_pos', `y_pos'.
		do
			--| FIXME to be implemented for pick-and-dropable.
		end

	screen_x: INTEGER is
			-- Horizontal offset of `Current' relative to screen.
		do
		end

	screen_y: INTEGER is
			-- Vertical offset of `Current' relative to screen.
		do
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
--| Revision 1.23  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.8.13  2001/03/22 00:43:24  rogers
--| Fixed `enable_sensitive' and `disable_sensitive' in the case where
--| `Current' is parented in an `EV_MENU_BAR' and therefore always visible in
--| the window. Previously, the visual appearence of `Current' would not change
--| until the mouse was clicked on it or the window was re-sized.
--|
--| Revision 1.13.8.12  2001/03/21 18:29:25  rogers
--| Added missing comments to `update_parent_size' and `wel_set_text'.
--|
--| Revision 1.13.8.11  2001/02/06 01:57:34  rogers
--| Added find_item_at_position, screen_x and screen_y.
--|
--| Revision 1.13.8.10  2000/12/29 18:22:18  rogers
--| Added disable_default_processing.
--|
--| Revision 1.13.8.9  2000/11/29 00:37:32  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.13.8.8  2000/09/27 16:15:20  rogers
--| Redefined wel_set_text from EV_MENU_ITEM_IMP. Fixed the bug in
--| wel_set_text where setting the text would do nothing once `Current'
--| had been parented.
--|
--| Revision 1.13.8.7  2000/09/13 22:07:45  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.13.8.6  2000/08/21 18:08:09  rogers
--| Removed undefinition of destroy.
--|
--| Revision 1.13.8.5  2000/08/18 19:29:46  rogers
--| Added comments to initialize and default_create.
--|
--| Revision 1.13.8.4  2000/08/16 22:08:27  rogers
--| Redefined enable_sensitive. Added set_insensitive.
--|
--| Revision 1.13.8.3  2000/08/16 19:09:17  rogers
--| Redefined has_parent and disable_sensitive.
--|
--| Revision 1.13.8.2  2000/06/09 20:30:09  rogers
--| Added internal_propagate_pointer_double_press. Comments. Formatting.
--|
--| Revision 1.13.8.1  2000/05/03 19:09:52  oconnor
--| mergred from HEAD
--|
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
