indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TREE_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make(par: EV_CONTAINER) is
			-- Create the tab and initalise the objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
				-- Commands used by the tab.
			h1: EV_HORIZONTAL_SEPARATOR
			
		do
			{ANY_TAB} Precursor (Void)
			create cmd2.make (~add_item)
			create f1.make (Current, 0, 0, "Add Item To Subtree", cmd2, cmd2)
			create cmd2.make (~selected)
			create f2.make (Current, 1, 0, "Selected", Void, cmd2)
			create cmd2.make (~selected_item)
			create f3.make (Current, 2, 0, "Selected Item", Void, cmd2)
			create cmd1.make (~remove_tree)
			create h1.make (Current)
			set_child_position (h1, 3, 0, 4, 3)
			create b1.make_with_text (Current, "Remove All Children")
			b1.set_vertical_resize (False)
			b1.add_click_command (cmd1, Void)
			set_child_position (b1, 4, 1, 5, 2)

			set_parent (par)			
			end

	set_tree is
			-- Initialize the tree with a root
		do
			if tree_items = Void then
				create tree_items.make
				create t1.make_with_text (current_widget, "Root")
				f1.combo.set_editable (True)
				create e1.make_with_text (f1.combo, "Root")
				e1.set_data(t1)
				tree_items.extend(e1)
			end
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="Tree"
		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_TREE
		-- The current demo.

	f1: COMBO_FEATURE_MODIFIER
		-- A combo feature modifier for the action window.
	
	f2,f3: TEXT_FEATURE_MODIFIER
		-- Text feature modifiers for the action window.

	b1: EV_BUTTON
		-- A button for the action window.
	
	t1: EV_TREE_ITEM
		-- An item for the tree.
	
	e1: EV_LIST_ITEM
		-- An item for the combo box.
	
	tree_items: LINKED_LIST[EV_LIST_ITEM]
		-- A list of all the children that have been added to the tree.

feature -- Execution Feature

	
	add_item (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Adds an item to the tree
		local
			temp_holder: EV_TREE_ITEM_HOLDER
			found: BOOLEAN
			new_text: STRING
		do
			if f1.combo.has_selection then
			from
				tree_items.start
			until
				found
			loop
				if equal (tree_items.item.text, f1.combo.selected_text) then
					new_text:="ITEM "
					new_text.append_string (tree_items.count.out)
					temp_holder ?= tree_items.item.data
					create t1.make_with_text (temp_holder, new_text)
					create e1.make_with_text (f1.combo, new_text)
					e1.set_data(t1)
					tree_items.extend(e1)
					found := True
				end
				tree_items.forth
			end
			end
		end

	remove_tree (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Removes the whole tree except for the root.
		do
			tree_items.wipe_out
			--f1.combo.clear_items
			--create e1.make_with_text (f1.combo, "Root")
			--e1.set_data(t1)
			--tree_items.extend(e1)
		end

	selected_item (arg : EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Displays the selected item.
		do
			if current_widget.selected then
				f3.set_text (current_widget.selected_item.text)
			end
		end

	selected (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Is an item selected.
		do
			if current_widget.selected then
				f2.set_text ("Yes")
			else
				f2.set_text ("No")
			end
		end

end -- class TREE_TAB

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

