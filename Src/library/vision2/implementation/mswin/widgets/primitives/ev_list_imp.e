indexing
	description: "EiffelVision list. Mswindows implementation."
	note: "In the wel_list, the index starts with the element %
		% number zero although in the linked_list, it starts  %
		% with number one. That is the reason for the graps in %
		% the list calls."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class 

	EV_LIST_IMP

inherit

	EV_LIST_I

	EV_ITEM_EVENTS_CONSTANTS_IMP
	
	EV_ITEM_CONTAINER_IMP
		redefine
			ev_children
		end

	EV_PRIMITIVE_IMP
		undefine
			initialize_colors
		redefine
			make
		end

	WEL_SINGLE_SELECTION_LIST_BOX
		rename
			make as wel_make,
			destroy as wel_desroy,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
			-- The signatures are differents in WEL and Vision.
			selected_item as single_selected_item
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
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
			on_char,
			on_key_up,
			background_color,
			foreground_color
		redefine
			selected,
			select_item,
			on_lbn_dblclk,
			on_lbn_selchange,
			default_style
		end

	WEL_MULTIPLE_SELECTION_LIST_BOX
		rename
			make as wel_make,
			destroy as wel_destroy,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
			-- The signatures are differents in WEL and Vision.
			selected_items as multiple_selected_items
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- and EV_PRIMITIVE_IMP
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
			on_char,
			on_key_up,
			background_color,
			foreground_color
		redefine
			selected,
			select_item,
			on_lbn_dblclk,
			on_lbn_selchange,
			default_style
		select
			wel_destroy
		end

creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a list widget with `par' as parent.
			-- By default, it is a single selection list,
			-- use set_selection to change it into a multiple
			-- selection list.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			wel_make (par_imp, 0, 0, 0, 0, 0)
			initialize
			is_multiple_selection := False
		end	

feature -- Access

	get_item (index: INTEGER): EV_LIST_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		do
			Result ?= (ev_children.i_th (index)).interface
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			if is_multiple_selection then
				Result := {WEL_MULTIPLE_SELECTION_LIST_BOX}	Precursor
			else
				Result := {WEL_SINGLE_SELECTION_LIST_BOX} Precursor
			end
		end

	is_multiple_selection: BOOLEAN
			-- True if the user can choose several items,
			-- False otherwise

	selected_item: EV_LIST_ITEM_IMP is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the item which has the focus.
		do
			if is_multiple_selection then
				Result := ev_children.i_th (caret_index + 1)
			else
				Result := ev_children.i_th (single_selected_item + 1)
			end
		end

	selected_items: LINKED_LIST [EV_LIST_ITEM_IMP] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		local
			index: INTEGER
		do
			!! Result.make
			if is_multiple_selection then
				from
					index := multiple_selected_items.lower
				until
					index > multiple_selected_items.upper
				loop
					Result.extend (ev_children.i_th(multiple_selected_items.item (index)))
					index := index + 1
				end
			else
				Result.extend (selected_item)
			end
		end

feature -- Status setting

	select_item (index: INTEGER) is
			   -- Select item at the zero-based `index'.
		do
			if is_multiple_selection then
				{WEL_MULTIPLE_SELECTION_LIST_BOX} Precursor (index)
			else
				{WEL_SINGLE_SELECTION_LIST_BOX} Precursor (index)
			end
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		local
			wel_imp: WEL_WINDOW
		do
			if not is_multiple_selection then
				is_multiple_selection := True
				wel_imp ?= parent_imp
				wel_destroy
				wel_make (wel_imp, 0, 0, 0, 0, 0)
				copy_list
			end
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		local
			wel_imp: WEL_WINDOW
		do
			if is_multiple_selection then
				is_multiple_selection := False
				wel_imp ?= parent_imp
				wel_destroy
				wel_make (wel_imp, 0, 0, 0, 0, 0)
				copy_list
			end
		end

feature {NONE} -- Implementation

	copy_list is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					add_string (ev_children.item.text)
					ev_children.forth
				end
			end
		end

	add_item (an_item: EV_LIST_ITEM) is
			-- Add an item to the list
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			ev_children.extend (item_imp)
			add_string (name_item)
			item_imp.set_id (ev_children.count - 1)
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	remove_item (an_id: INTEGER) is
			-- Remove the child whose id is `id'.
		do
			delete_string (an_id)
			ev_children.go_i_th (an_id + 1)
			ev_children.remove
			from
			until
				ev_children.after
			loop
				ev_children.item.set_id (ev_children.index - 1)
				ev_children.forth
			end
		end

feature {NONE} -- Implementation

	on_lbn_selchange is
			-- The selection is about to change
		do
			selected_item.execute_command (Cmd_item_activate, Void)
		end

	on_lbn_dblclk is
			-- Double click on a string
		do
			selected_item.execute_command (Cmd_item_dblclk, Void)
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	ev_children: LINKED_LIST [EV_LIST_ITEM_IMP]

feature {NONE} -- Implementation : WEL features

	default_style : INTEGER is
		do
			if is_multiple_selection then
				Result := {WEL_MULTIPLE_SELECTION_LIST_BOX} Precursor
			else
				Result := {WEL_SINGLE_SELECTION_LIST_BOX} Precursor
			end
		end
	
end -- class EV_LIST_IMP

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
