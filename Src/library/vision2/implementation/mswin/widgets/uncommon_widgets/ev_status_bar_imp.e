--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision status bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_IMP

inherit
	EV_STATUS_BAR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			parent_imp,
			set_parent,
			interface
		end

	EV_ITEM_LIST_IMP [EV_STATUS_BAR_ITEM]
		redefine
			interface
		end

	WEL_STATUS_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			set_minimum_height as wel_set_minimum_height,
			text as wel_text,
			set_text as wel_set_text,
			item as wel_item,
			move as move_to,
			enabled as is_sensitive, 
			width as wel_width,
			height as wel_height
		undefine
			window_process_message,
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_kill_focus,
			on_set_cursor,
			hide,
			show
		redefine
			default_style
		end

	WEL_DT_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a status bar with one part.
		do 
			base_make (an_interface)
			wel_make (default_parent, 0)
			!! ev_children.make (0)
		end

feature -- Access
	
	ev_children: ARRAYED_LIST [EV_STATUS_BAR_ITEM_IMP]
			-- List of the children

	parent_imp: EV_TITLED_WINDOW_IMP is
			-- It is a window
		do
			Result ?= {EV_PRIMITIVE_IMP} Precursor
		end

	count: INTEGER is
			-- Number of direct children of the holder.
		do
			Result := ev_children.count
		end

	--FIXME Should no longer be required as is now in item_list.
	--item: EV_STATUS_BAR_ITEM is
	--	do
	--	end

feature -- Element change


	
	set_parent (par: EV_TITLED_WINDOW) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		local
			par_imp: EV_TITLED_WINDOW_IMP
			ww: WEL_WINDOW
		do
			if par /= Void then
				if parent_imp /= Void then
					parent_imp.remove_status_bar
				end
				ww ?= par.implementation
				wel_set_parent (ww)
				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
				--| FIXME par_imp.set_status_bar (Current)
			elseif parent_imp /= Void then
				parent_imp.remove_status_bar
				wel_set_parent (default_parent)
			end
		end

	insert_item (item_imp: EV_STATUS_BAR_ITEM_IMP; an_index: INTEGER) is
			-- Insert an item at `an_index' position
		do
			ev_children.go_i_th (an_index)
			ev_children.put_left (item_imp)
			update_edges
			update_texts
		end

	move_item (item_imp: like item_type; an_index: INTEGER) is
			-- Move `item_imp' to the `an_index' position.
		do
			ev_children.prune_all (item_imp)
			ev_children.go_i_th (an_index)
			ev_children.put_left (item_imp)
			update_edges
			update_texts
		end

	remove_item (an_item: EV_STATUS_BAR_ITEM_IMP) is
			-- Remove the given item from the status bar.
		do
			ev_children.prune_all (an_item)
			update_edges
			update_texts
		end

	clear_items is
			-- Clear all the items of the list.
		do
			ev_children.wipe_out
			update_edges
		end

feature -- Basic operation

	internal_set_text (item_imp: EV_STATUS_BAR_ITEM_IMP; txt: STRING) is
			-- Make `txt' the text of `item_imp'.
		local
			idi: INTEGER
		do
			idi := ev_children.index_of (item_imp, 1) - 1
			set_text_part (idi, txt)
		end

	internal_get_index (item_imp: EV_STATUS_BAR_ITEM_IMP): INTEGER is
			-- Return the index of `item' in the list.
		do
			Result := ev_children.index_of (item_imp, 1) - 1
		end

feature -- Implementation

	update_edges is
			-- Update the status after addition or remove of a child.
		local
			clist: ARRAYED_LIST [EV_STATUS_BAR_ITEM_IMP]
			array: ARRAY [INTEGER]
		do
			clist := ev_children
			if clist.empty then
				set_simple_mode
				set_simple_text ("")	
			else
				if clist.last.width /= -1 then
					!! array.make (1, clist.count + 1)
					from
						clist.start
						array.put (clist.item.width, clist.index)
						clist.forth
					until
						clist.after
					loop
						array.put (clist.item.width + array.item (clist.index - 1), clist.index)
						clist.forth
					end
					array.put (-1, clist.count + 1)
				else
					!! array.make (1, clist.count)
					from
						clist.start
						array.put (clist.item.width, clist.index)
						clist.forth
					until
						clist.islast or clist.off
					loop
						array.put (clist.item.width + array.item (clist.index - 1), clist.index)
						clist.forth
					end
					if not clist.off then
						array.put (clist.item.width, clist.index)
					end
				end
				set_parts (array)
			end
		end

	update_texts is
			-- Update the texts after addition or remove of a child.
		local
			clist: ARRAYED_LIST [EV_STATUS_BAR_ITEM_IMP]
		do
			clist := ev_children
			from
				clist.start
			until
				clist.after
			loop
				if clist.item.pixmap_imp /= Void then
					set_child_owner_draw (clist.item, True)
				else
					set_child_owner_draw (clist.item, False)
				end
				clist.forth
			end
			if number_of_parts > count then
				set_text_part (number_of_parts - 1, "")
			end
		end

	set_child_owner_draw (current_child: EV_STATUS_BAR_ITEM_IMP; bool: BOOLEAN) is
			-- Set `current_child' to ownerdrawn.
			-- The child will be drawn by the status bar when on_wmdraw is recieved
			-- by the status bar. See also EV_INTERNAL_SILLY_WIDGET_IMP.
		local
			counter: INTEGER
			child_found: BOOLEAN
			clist: ARRAYED_LIST [EV_STATUS_BAR_ITEM_IMP]
		do
			from
				counter := 0
				clist := ev_children
				clist.start
			until
				counter = clist.count or child_found
			loop
				if equal (clist.item, current_child) then
					if bool then
						set_part_owner_drawn (counter, 0 ,0)
					else
						set_text_part (clist.index - 1, clist.item.text)
					end
					child_found := True
				end
				counter := counter + 1
				if not child_found then
					clist.forth
				end
			end
		end


feature {NONE} -- Implementation

	item_type: EV_STATUS_BAR_ITEM_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		do
		end

feature {EV_INTERNAL_SILLY_WINDOW_IMP} -- Implementation

	vertical_offset : INTEGER is 4
			-- 4 pixels down will center the text.
			-- This is always true as status bars are fixed to 16 pixels high.

	draw_item (id1: INTEGER; struct: WEL_DRAW_ITEM_STRUCT)is
			-- Draw the status bar item.
		local
			dc: WEL_DC
			rect: WEL_RECT
			item_id: INTEGER
			current_item: EV_STATUS_BAR_ITEM_IMP
			pixmap : EV_PIXMAP_IMP
			P: EV_PIXMAP
			bitmap: WEL_BITMAP
			rect2: WEL_RECT
		do
			dc := struct.dc
			rect := struct.rect_item
			item_id := struct.item_id + 1
			current_item := ev_children @ item_id
			if current_item.pixmap /= Void then
				pixmap ?= current_item.pixmap.implementation
				bitmap := pixmap.bitmap
				dc.draw_bitmap (bitmap, rect.left + 1, rect.top + 1, bitmap.width, bitmap.height)
					-- Draw `bitmap'
				create rect2.make (bitmap.width + rect.left + 2, vertical_offset, rect.width + rect.left, vertical_offset + rect.height)
				dc.set_background_transparent
				dc.draw_text (current_item.text, rect2, Dt_left)
					-- Draw text associated with status bar item.
			end
		end	

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_visible + Ws_child + Sbars_sizegrip
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				never_called : False
					-- This should never be called as the status
					-- bar should not have focus.
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				never_called : False
					-- This should never be called as the status
					-- bar should not have focus.
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
			cwin_show_window (hwnd, cmd_show)
		end

feature {NONE}

	interface: EV_STATUS_BAR

end -- class EV_STATUS_BAR_IMP

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
--| Revision 1.20  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.19.4.7  2000/02/05 02:27:24  brendel
--| Commented out one line of code.
--|
--| Revision 1.19.4.6  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.19.4.5  2000/01/27 19:30:32  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.19.4.4  2000/01/20 18:31:47  king
--| Changed internal_bitmap to bitmap.
--|
--| Revision 1.19.4.3  2000/01/19 22:33:50  rogers
--| Removed item as it is noy inherited from EV_ITEM_LIT_IMP.
--|
--| Revision 1.19.4.2  1999/12/17 00:17:16  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP. make now takes an interface.
--|
--| Revision 1.19.4.1  1999/11/24 17:30:36  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.2.3  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
