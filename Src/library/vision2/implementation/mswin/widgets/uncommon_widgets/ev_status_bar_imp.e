indexing 
	description: "EiffelVision status bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_IMP

inherit
	EV_STATUS_BAR_I

	EV_PRIMITIVE_IMP
		rename
			make as wrong_make
		redefine
			parent_imp,
			set_parent
		end

	EV_ARRAYED_LIST_ITEM_HOLDER_IMP
		redefine
			move_item
		end

	WEL_STATUS_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as displayed,
			destroy as wel_destroy,
			set_minimum_height as wel_set_minimum_height,
			text as wel_text,
			set_text as wel_set_text
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

	make (par: EV_WINDOW) is
			-- Create a status bar with one part.
		do 
			wel_make (default_parent, 0)
			!! ev_children.make (0)
			set_parent (par)
		end

feature -- Access
	
	ev_children: ARRAYED_LIST [EV_STATUS_BAR_ITEM_IMP]
			-- List of the children

	parent_imp: EV_WINDOW_IMP is
			-- It is a window
		do
			Result ?= {EV_PRIMITIVE_IMP} Precursor
		end

	count: INTEGER is
			-- Number of direct children of the holder.
		do
			Result := ev_children.count
		end

feature -- Element change

	set_parent (par: EV_WINDOW) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		local
			par_imp: EV_WINDOW_IMP
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
				par_imp.set_status_bar (Current)
			elseif parent_imp /= Void then
				parent_imp.remove_status_bar
				wel_set_parent (default_parent)
			end
		end

	insert_item (item_imp: EV_STATUS_BAR_ITEM_IMP; index: INTEGER) is
			-- Insert an item at `index' position
		do
			ev_children.go_i_th (index)
			ev_children.put_left (item_imp)
			update_edges
			update_texts
		end

	move_item (item_imp: like item_type; index: INTEGER) is
			-- Move `item_imp' to the `index' position.
		do
			ev_children.prune_all (item_imp)
			ev_children.go_i_th (index)
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
						clist.islast
					loop
						array.put (clist.item.width + array.item (clist.index - 1), clist.index)
						clist.forth
					end
					array.put (clist.item.width, clist.index)
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
				set_text_part (clist.index - 1, clist.item.text)
				clist.forth
			end
			if number_of_parts > count then
				set_text_part (number_of_parts - 1, "")
			end
		end

	set_child_owner_draw (current_child: EV_STATUS_BAR_ITEM_IMP) is
			-- Set `current_child' to ownerdrawn.
			-- The child will be drawn by the status bar when on_wmdraw is recieved
			-- by the status bar. See also EV_INTERNAL_SILLY_WIDGET_IMP.
		local
			counter: INTEGER
			child_found: BOOLEAN
		do
			from
				counter := 0
				ev_children.start
			until
				counter = ev_children.count or child_found
			loop
				if equal (ev_children.item, current_child) then
					set_part_owner_drawn (counter, 0 ,0)
					child_found := True
				end
				counter := counter + 1
				if not child_found then
					ev_children.forth
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
			bitmap: WEL_BITMAP
			rect2: WEL_RECT
		do
			dc := struct.dc
			rect := struct.rect_item
			item_id := struct.item_id + 1
			current_item := ev_children @ item_id
			pixmap ?= current_item.pixmap.implementation
			bitmap := pixmap.internal_bitmap
			dc.draw_bitmap (bitmap, rect.left, rect.top, bitmap.width, bitmap.height)
				-- Draw `bitmap'
			create rect2.make (bitmap.width + rect.left, vertical_offset, rect.width + rect.left, vertical_offset + rect.height)
			dc.set_background_transparent
			dc.draw_text (current_item.text, rect2, Dt_left)
				-- Draw text associated with status bar item.
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
