indexing
	description:
		"EiffelVision tree-item, gtk implementation"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_ITEM_IMP

inherit
	EV_TREE_ITEM_I
	
	EV_ITEM_IMP
--		undefine
--			set_label_widget,
--			label_widget
--		end

	EV_TREE_ITEM_CONTAINER_IMP
		rename
			make as old_make,
			interface as widget_interface,
			set_interface as set_widget_interface,
			add_double_click_command as old_add_dblclk,
			remove_double_click_commands as old_remove_dblclk
		end

creation
	make_with_text

feature {NONE} -- Initialization

	make_with_text (par: EV_TREE_ITEM_CONTAINER; txt: STRING) is
			-- Create a tree-item with `txt' as label and
			-- `par' as parent.
		local
			a: ANY
		do
			a ?= txt.to_c
			widget := gtk_tree_item_new_with_label ($a)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		do
			check
				Not_yet_implemented: False
			end
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		do
			Result := c_gtk_tree_item_expanded (widget)
		end

feature -- Event : command association

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the menu item is activated
		do
			add_command ("expand", cmd, arg)
			add_command ("collapse", cmd, arg)
		end

feature -- Event -- removing command association

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		do
			check False end
		end

feature {EV_TREE_ITEM} -- Implementation

	add_item (item: EV_TREE_ITEM) is
			-- Add `item' to the list
		local
			item_imp: EV_TREE_ITEM_IMP
			p: POINTER
		do
			item_imp ?= item.implementation
			check
				correct_imp: item_imp /= Void
			end
			if GTK_TREE_ITEM_SUBTREE(widget) = default_pointer then
				p := gtk_tree_new
				--gtk_widget_show (p)
				gtk_tree_item_set_subtree (widget, p)
			end
			gtk_tree_append (GTK_TREE_ITEM_SUBTREE(widget), item_imp.widget)
			gtk_widget_show (item_imp.widget)
		end

end -- class EV_TREE_ITEM_IMP

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
--|----------------------------------------------------------------
