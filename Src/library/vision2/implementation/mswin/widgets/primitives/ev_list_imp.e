indexing
	description: "EiffelVision list. Mswindows implementation."
	note: "In the wel_list, the index starts with the element %
		% number zero although in the linked_list, it starts  %
		% with number one. That is the reason for the grap in %
		% the list calls."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class 

	EV_LIST_IMP

inherit

	EV_LIST_I
	
	EV_ITEM_CONTAINER_IMP
		export
			{EV_LIST_ITEM_IMP} set_name
		redefine
			children
		end

	EV_WIDGET_IMP

creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a list widget with `par' as parent.
			-- By default, it is a single selection list,
			-- use set_selection to change it into a multiple
			-- selection list.
		do
			test_and_set_parent (par)
			initialize
			!EV_WEL_MULTIPLE_SELECTION_LIST_BOX! wel_window.make (parent_imp.wel_window, Current)
		end	

feature -- Status report

	count: INTEGER is
			-- Number of lines
		do
			Result := wel_window.count
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := wel_window.selected
		end

	is_multiple_selection: BOOLEAN
			-- True if the user can choose several items,
			-- False otherwise

	selected_item: EV_LIST_ITEM_IMP is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the item which has the focus.
		do
			Result := children.i_th (wel_window.caret_index + 1)
		end

	selected_items: LINKED_LIST [EV_LIST_ITEM_IMP] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		local
			ml: EV_WEL_MULTIPLE_SELECTION_LIST_BOX
			index: INTEGER
		do
			!! Result.make
			if is_multiple_selection then
				ml ?= wel_window
				from
					index := ml.selected_items.lower
				until
					index > ml.selected_items.upper
				loop
					Result.extend (children.i_th(ml.selected_items.item (index)))
					index := index + 1
				end
			else
				Result.extend (selected_item)
			end
		end

feature -- Status setting

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		local
			new_list: EV_WEL_MULTIPLE_SELECTION_LIST_BOX
		do
			is_multiple_selection := True
			!! new_list.make (parent_imp.wel_window, Current)
			copy_list (new_list)
			wel_window.destroy
			wel_window := new_list
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		local
			new_list: EV_WEL_SINGLE_SELECTION_LIST_BOX
		do
			is_multiple_selection := False
			!! new_list.make (parent_imp.wel_window, Current)
			copy_list (new_list)
			wel_window.destroy
			wel_window := new_list
		end

feature -- Implementation

	copy_list (a_list: WEL_LIST_BOX) is
			-- Take an empty list and initialize all the children with
			-- the contents of `children'.
		do
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					a_list.add_string (children.item.text)
					children.forth
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
			children.extend (item_imp)
			wel_window.add_string (name_item)
			item_imp.set_id (children.count - 1)
		end

	remove_item (id: INTEGER) is
			-- Remove the child whose id is `id'.
		do
			wel_window.delete_string (id)
			children.go_i_th (id + 1)
			children.remove
			from
			until
				children.after
			loop
				children.item.set_id (children.index - 1)
				children.forth
			end
		end

	on_lbn_selchange is
			-- The selection is about to change
		do
			if selected_item.command /= Void then
				selected_item.command.execute (selected_item.arguments)
			end
		end

	on_lbn_dblclk is
			-- Double click on a string
		do
			if selected_item.dc_command /= Void then
				selected_item.dc_command.execute (selected_item.dc_arguments)
			end
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	children: LINKED_LIST [EV_LIST_ITEM_IMP]

	wel_window: EV_WEL_LIST_BOX
	
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
