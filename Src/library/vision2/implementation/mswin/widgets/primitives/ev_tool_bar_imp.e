--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision toolbar, mswindows implementation."
	status: "See notica at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			minimum_width,
			on_right_button_down,
			on_left_button_down,
			on_middle_button_down,
			minimum_height,
			integrate_changes,
			pnd_press
		redefine
			parent_imp,
			wel_move_and_resize,
			on_left_button_up,
			on_right_button_up,
			on_middle_button_up,
			on_mouse_move,
			on_key_down,
			destroy,
			interface,
			initialize
		end

	EV_SIZEABLE_CONTAINER_IMP
		undefine
			internal_set_minimum_width,
			internal_set_minimum_height,
			internal_set_minimum_size
		redefine
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			interface
		end

	EV_HASH_TABLE_ITEM_HOLDER_IMP [EV_TOOL_BAR_ITEM]
		redefine
			interface,
			initialize
		end

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		redefine
			interface
		end
	
	WEL_FLAT_TOOL_BAR
		rename
			make as wel_make,
			button_count as count,
			insert_button as wel_insert_button,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			destroy_item as wel_destroy_item,
			item as wel_item,
			enabled as is_sensitive, 
			width as wel_width,
			height as wel_height,
			tooltip as wel_tooltip,
			set_tooltip as wel_set_tooltip,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize
		undefine
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_key_up,
			on_key_down,
			on_kill_focus,
			on_set_focus,
			on_set_cursor,
			window_process_message,
			show,
			hide
		redefine
			wel_set_parent,
			wel_resize,
			wel_move,
			wel_move_and_resize,
			default_process_message
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tool-bar.
		do
			base_make (an_interface)
		end

	initialize is
		local
			ctrl: EV_INTERNAL_TOOL_BAR_IMP
		do
			create ctrl.make (default_parent, "EV_INTERNAL_TOOL_BAR_IMP")
			wel_make (ctrl, 0)			
			{EV_PRIMITIVE_IMP} Precursor
			{EV_HASH_TABLE_ITEM_HOLDER_IMP} Precursor
			create ev_children.make (2)
		end

feature -- Access

	bar: EV_INTERNAL_TOOL_BAR_IMP is
			-- WEL container of the tool-bar
		do
			Result ?= wel_parent
		end

	ev_children: ARRAYED_LIST [EV_TOOL_BAR_BUTTON_IMP]
			-- List of the direct children of the item holder.
			-- Should be define here, but is not because we cannot
			-- do the hastable deferred, it doesn't work, it should,
			-- but it doesn't.

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of this tool-bar.
		do
			if bar.parent = default_parent then
				Result := Void
			else
				Result ?= bar.parent
			end
		end

feature -- Status report

	separator_width: INTEGER is
			-- Current width of a separator
		do
			Result := 8
		end

	shown: BOOLEAN is
			-- Is the window shown?
		do
			Result := flag_set (bar.style, Ws_visible)
		end

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.interface.prune (Current.interface)
			end
			bar.destroy
		end

feature -- Element change

	insert_item (button: EV_TOOL_BAR_BUTTON_IMP; an_index: INTEGER) is
			-- Insert `button' at the `an_index' position in the tool-bar.
		local
			but: WEL_TOOL_BAR_BUTTON
			num: INTEGER
			pixmap: EV_PIXMAP_IMP
			gray_pixmap: EV_PIXMAP_IMP
			button_text: STRING
		do
			-- We create the button
			inspect button.type
			when 1 then -- Usual button
				create but.make_button (-1, button.id)
			when 2 then -- Check button
				create but.make_check (-1, button.id)
			when 3 then -- Radio button
				create but.make_check (-1, button.id)
			when 4 then -- Option button
				create but.make_button (-1, button.id)
			when 5 then -- Separator
				create but.make_separator
				but.set_command_id (button.id)
			end
	
				-- First, we take care of the pixmap,
			pixmap := button.pixmap_imp
			if pixmap /= Void then
					-- The first bitmap added determine the size of all bitmaps
				if not has_bitmap then
					set_bitmap_size(pixmap.width, pixmap.height)
				end

				gray_pixmap := button.gray_pixmap_imp
				if gray_pixmap = Void then
						-- No gray pixmap, so both normal and hot state will
						-- have the same bitmap.
					gray_pixmap := pixmap
				end

				add_pixmap (gray_pixmap)
				add_hot_pixmap (pixmap)
				but.set_bitmap_index (last_bitmap_index)
			end

				-- Then, the text of the button.
			button_text := button.text -- Speed optimization
			if button_text /= Void and then not button_text.empty then
				add_strings (<<button_text>>)
				but.set_string_index (last_string_index)
			end

			-- Finally, we insert the button
			wel_insert_button (an_index - 1, but)
			--children.put (button, button.id)
			ev_children.go_i_th (an_index - 1)
			ev_children.put_right (button)

			-- We notify the change to integrate them if necessary
			notify_change (2 + 1)
		end

	remove_item (button: EV_TOOL_BAR_BUTTON_IMP) is
			-- Remove button from the toolbar.
		local
			id1: INTEGER
		do
			id1 := ev_children.index_of (button, 1)
			delete_button (internal_get_index (button))
			ev_children.go_i_th (id1)
			ev_children.remove
			notify_change (2 + 1)
		end

feature -- Basic operation

	internal_get_index (button: EV_TOOL_BAR_BUTTON_IMP): INTEGER is
			-- Retrieve the current index of the button with
			-- `command_id' as id.
		do
			Result := cwin_send_message_result (
				wel_item, Tb_commandtoindex, button.id, 0)
		end

	compute_minimum_width is
			-- Update the minimum-size of the tool-bar.
		local
			num: INTEGER
		do
			if comctl32_version >= version_471 then
					-- New version using API available starting with IE4.
				internal_set_minimum_width (get_max_width)
			else
					-- Old version
				num := separator_count
				num := (count - num) * buttons_width + num * separator_width
				internal_set_minimum_width (num)
			end
		end

	compute_minimum_height is
			-- Update the minimum-size of the tool-bar.
		do
			if comctl32_version >= version_471 then
					-- New version using API available starting with IE4.
				internal_set_minimum_height (get_max_height)
			else
					-- No API available, we only guess the right value...
				internal_set_minimum_height (buttons_height + 6)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and then
			-- minimum_height of the object.
		local
			num: INTEGER
		do
			num := separator_count
			num := (count - num) * buttons_width + num * separator_width
			internal_set_minimum_size (num, buttons_height + 6)
		end

	internal_reset_button (but: EV_TOOL_BAR_BUTTON_IMP) is
			-- XX To update XX
			-- This function is used each time we change an attribute of a 
			-- button as the text or the pixmap. Yet, it should only be a 
			-- Temporary implementation. For now, no message is available to 
			-- change the text of a button. But this implementation should
			-- be changes as soon as windows allow a more direct way to 
			-- change an attribute.
		local
			an_index: INTEGER
		do
			an_index := internal_get_index (but) + 1
			remove_item (but)
			insert_item (but, an_index)
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TOOL_BAR_BUTTON_IMP is
			-- Find the item at the given position.
			-- Position is relative to the toolbar.
			-- If there is no button at (`x_pos',`y_pox'), the result is Void.
		local
			item_index: INTEGER
		do
			item_index := find_button(x_pos, y_pos)
			if item_index >= 0 then
				 Result := ev_children.i_th(item_index + 1)
			end
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos', `y_pos' and `button' to the
			-- appropriate event item.
		local
			it: EV_TOOL_BAR_BUTTON_IMP
			pt: WEL_POINT
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
				if it /= Void and it.is_transport_enabled and
				not parent_is_pnd_source then
					it.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
				elseif pnd_item_source /= Void then
					pnd_item_source.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
				end
			if it /= Void then
				it.interface.pointer_button_press_actions.call
				([x_pos - child_x (it.interface),
				child_y_absolute (it.interface) - y_pos, button, 0.0, 0.0, 0.0,
				pt.x, pt.y])
			end
		end

--	internal_propagate_event (
--		event_id: INTEGER;
--		x_pos: INTEGER;
--		y_pos: INTEGER; 
--		ev_data: EV_BUTTON_EVENT_DATA
--	) is
--			-- Propagate the `event_id' to the good child.
--		local
--			tbutton: EV_TOOL_BAR_BUTTON_IMP
--		do
--			tbutton := find_item_at_position (x_pos, y_pos)
--			if tbutton /= Void and then not tbutton.is_insensitive then
--				tbutton.execute_command (event_id, ev_data)
--			end
--		end

feature {NONE} -- Implementation

	item_type: EV_TOOL_BAR_BUTTON_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		do
		end

	separator_count: INTEGER is
			-- Number of separators in the toolbar.
			-- Necessary for the implementation of the minimum_width
			-- of the toolbar. As soon as the message Tb_getmaxsize
			-- is available, this feature should not be so usefull.
		local
			list: ARRAYED_LIST [EV_TOOL_BAR_BUTTON_IMP]
			original_index: INTEGER
		do
			from
				original_index := index
				list := ev_children
				list.start
			until
				list.after
			loop
				if list.item.type = 5 then
					Result := Result + 1
				end
				list.forth
			end
			ev_children.go_i_th (original_index)
		end

feature {NONE} -- Implementation

	add_pixmap(a_pixmap_imp: EV_PIXMAP_IMP) is
			-- Add a pixmap to the "toolbar" list of bitmaps.
		local
			mask_bitmap: WEL_BITMAP
			pixmap_icon: WEL_ICON
		do
			pixmap_icon := a_pixmap_imp.icon
			if pixmap_icon /= Void then
				add_icon(pixmap_icon)
			else
				mask_bitmap := a_pixmap_imp.mask_bitmap
					-- The bitmap should be selected in the device
					-- context, otherwise it is invalide.
				if mask_bitmap /= Void then
					add_masked_bitmap(a_pixmap_imp.bitmap, mask_bitmap)
				else
					add_bitmap(a_pixmap_imp.bitmap)
				end
			end
		end
		
	add_hot_pixmap(a_pixmap_imp: EV_PIXMAP_IMP) is
			-- Add a pixmap to the "toolbar" list of hot bitmaps.
		local
			mask_bitmap: WEL_BITMAP
			pixmap_icon: WEL_ICON
		do
			pixmap_icon := a_pixmap_imp.icon
			if pixmap_icon /= Void then
				add_icon(pixmap_icon)
			else
				mask_bitmap := a_pixmap_imp.mask_bitmap
				if mask_bitmap /= Void then
					add_hot_masked_bitmap(a_pixmap_imp.bitmap, mask_bitmap)
				else
					add_hot_bitmap(a_pixmap_imp.bitmap)
				end
			end
		end

feature {NONE} -- WEL Implementation

	wel_move_and_resize (
		a_x: INTEGER;
		a_y: INTEGER;
		a_width: INTEGER;
		a_height: INTEGER;
		repaint: BOOLEAN
	) is
			-- We must not resize the height of the tool-bar.
		do
			bar.move_and_resize (a_x, a_y, a_width, height, repaint)
			reposition
		end

	wel_resize (a_width, a_height: INTEGER) is
			-- We must not resize the height of the tool-bar.
		do
			bar.resize (a_width, height)
			reposition
		end

	wel_move (a_x, a_y: INTEGER) is
			-- We need to move the bar only.
		do
			bar.move (a_x, a_y)
		end

feature {NONE} -- WEL Implementation

	wel_set_parent (a_parent: WEL_WINDOW) is
			-- Change the parent of the current window.
		do
			bar.set_parent (a_parent)
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if msg = Wm_ncpaint then
				on_wm_ncpaint (wparam)
			end
		end

	on_wm_ncpaint (wparam: INTEGER) is
			-- Wm_ncpaint message (NON-CLIENT area PAINT)
			-- Draw the part that is below the toolbar
			-- i.e. the separation line.
		require
			exists: exists
		local
			dc: WEL_WINDOW_DC
			color: WEL_COLOR_REF
			pen: WEL_PEN
		do
			create dc.make (Current)
			dc.get

			create color.make_system (Color_btnshadow)
			create pen.make_solid (1, color)
			dc.select_pen (pen)
			dc.line (-1, y_position, width, y_position)
			dc.unselect_pen

			create color.make_system (Color_btnhighlight)
			create pen.make_solid (1, color)
			dc.select_pen (pen)
			dc.line (-1, y_position + 1, width, y_position + 1)
			dc.unselect_pen

			dc.quick_release
			disable_default_processing
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (1, keys, x_pos, y_pos)
--			if has_command (Cmd_button_one_release) then
--				execute_command (Cmd_button_one_release, ev_data)
--			end
--			internal_propagate_event (
--				Cmd_button_one_release, x_pos, y_pos, ev_data)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (2, keys, x_pos, y_pos)
--			if has_command (Cmd_button_two_release) then
--				execute_command (Cmd_button_two_release, ev_data)
--			end
--			internal_propagate_event (
--				Cmd_button_two_release, x_pos, y_pos, ev_data)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (3, keys, x_pos, y_pos)
--			if has_command (Cmd_button_three_release) then
--				execute_command (Cmd_button_three_release, ev_data)
--			end
--			internal_propagate_event (
--				Cmd_button_three_release, x_pos, y_pos, ev_data)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
--			ev_data := get_button_data (2, keys, x_pos, y_pos)
--			internal_propagate_event (
--				Cmd_motion_notify, x_pos, y_pos, ev_data)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

feature {EV_PND_TRANSPORTER_IMP}

	child_x (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is relative xcoor of `button' to `parent_imp'.
		local
			button_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			Result := button_rectangle.left
		end

	child_y_absolute (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is absolute ycoor of `button'.	
		local
			button_rectangle: WEL_RECT
			window_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
			b: EV_INTERNAL_TOOL_BAR_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			window_rectangle := window_rect
			b := bar
			Result := b.window_rect.top + 
				((window_rect.height - button_rectangle.height)//2) - 1
			
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (bar.item, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_TOOL_BAR

end -- class EV_TOOL_BAR_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.36  2000/03/31 17:46:06  rogers
--| Now inherits EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP. Removed
--| on_*****_button_down. Added internal_propagate_pointer_press.
--|
--| Revision 1.35  2000/03/29 06:58:06  pichery
--| Modification of the add of a pixmap in a button.
--|
--| Revision 1.34  2000/03/27 17:32:17  brendel
--| Added redefinition of initialize.
--|
--| Revision 1.33  2000/03/22 04:12:36  pichery
--| - Improved the minimum width and height function by using function
--|   from Comctrl32.dll version 4.71 and above when available.
--|
--| - Moved feature `separator_count'.
--|
--| - Fixed the feature `on_wm_ncpaint' which did not work...Now it works !!
--|
--| Revision 1.32  2000/03/22 03:01:39  pichery
--| Changed the implementation of `find_item_at_position'. The new
--| implementation has been valided.
--|
--| Revision 1.31  2000/03/22 01:24:40  pichery
--| Fixed bug with the minimum size (bug also corrected in WEL)
--|
--| Revision 1.30  2000/03/20 23:22:13  pichery
--| - EV_TOOL_BAR_IMP now inherit from WEL_FLAT_TOOL_BAR
--|    * ImageList can now be used internally for Comctrl32.dll > 4.70
--|    * Gray Images can now be used
--|    ...
--| - Implemented the "gray pixmap" behaviour.
--|
--| Revision 1.29  2000/03/14 20:09:08  brendel
--| Rearranged initialization
--|
--| Revision 1.28  2000/03/14 03:02:56  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.27.2.3  2000/03/14 00:05:52  brendel
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.27.2.2  2000/03/11 00:19:21  brendel
--| Renamed move to wel_move.
--| Renamed resize to wel_resize.
--| Renamed move_and_resize to wel_move_and_resize.
--|
--| Revision 1.27.2.1  2000/03/09 21:39:48  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.27  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.26  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.4.1.2.9  2000/02/01 23:59:34  rogers
--| Changed the type of EV_HASH_TABLE_ITEM_HOLDER_IMP items 
--| from EV_TOOL_BAR_BUTTON to EV_TOOL_BAR_ITEM where it is inherited.
--|
--| Revision 1.24.4.1.2.8  2000/01/31 18:14:28  rogers
--| Tooltip and set_tooltip inherited from wel_tool_bar have been 
--| renamed as wel_tooltip and wel_set_tooltip.
--|
--| Revision 1.24.4.1.2.7  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.24.4.1.2.6  2000/01/27 19:30:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.4.1.2.5  2000/01/25 17:37:53  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.24.4.1.2.4  2000/01/24 21:21:15  rogers
--| Removed children which was the list of children stored in a hash table. 
--| removed clear_items, remove_all_items and reset_contents. 
--| find_item_at_position now searches ev_children for the item.
--|
--| Revision 1.24.4.1.2.3  2000/01/21 20:45:21  rogers
--| ev_childen is longer children.linear_representation, and is maintained 
--| as well as children. Find item at position has been re-implemented, 
--| albeit in a rather slow fashion.
--|
--| Revision 1.24.4.1.2.2  1999/12/17 00:32:23  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--| Swapped children with ev_children for consistancy with other classes.
--|
--| Revision 1.24.4.1.2.1  1999/11/24 17:30:35  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.3  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
