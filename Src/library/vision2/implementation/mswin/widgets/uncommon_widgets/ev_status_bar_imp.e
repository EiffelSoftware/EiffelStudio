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
		redefine
			parent_imp,
			set_parent,
			on_key_down
		end

	EV_ITEM_HOLDER_IMP

	WEL_STATUS_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			set_minimum_height as wel_set_minimum_height,
			text as wel_text,
			set_text as wel_set_text
		undefine
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
			on_kill_focus
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a status bar with one part.
		do
			wel_make (default_parent.item, 0)
			!! ev_children.make
		end

feature -- Access

	parent_imp: EV_WINDOW_IMP is
			-- It is a window
		do
			Result ?= {EV_PRIMITIVE_IMP} Precursor
		end

	ev_children: LINKED_LIST [EV_STATUS_BAR_ITEM_IMP]
			-- List of the children

	count: INTEGER is
			-- Number of children in the status bar.
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
				wel_set_parent (default_parent.item)
			end
		end

	add_item (an_item: EV_STATUS_BAR_ITEM_IMP) is
			-- Add a new item to the status bar.
		do
			ev_children.extend (an_item)
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

feature {NONE} -- Inapplicable

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

feature -- Implementation

	update_edges is
			-- Update the status after addition or remove of a child.
		local
			clist: LINKED_LIST [EV_STATUS_BAR_ITEM_IMP]
			array: ARRAY [INTEGER]
		do
			clist := ev_children
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

	update_texts is
			-- Update the texts after addition or remove of a child.
		local
			clist: LINKED_LIST [EV_STATUS_BAR_ITEM_IMP]
		do
			clist := ev_children
			from
				clist.start
			until
				clist.after
			loop
				set_text_part (clist.index - 1, clist.item.text)
				clist.item.set_id (clist.index)
				clist.forth
			end
			if number_of_parts > count then
				set_text_part (number_of_parts - 1, "")
			end
		end

feature {NONE} -- WEL Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_KEY_EVENT_DATA
		do
			if has_command (Cmd_key_press) then
				data := get_key_data (virtual_key, key_data)
				execute_command (Cmd_key_press, data)
			end
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
