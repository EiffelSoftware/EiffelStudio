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
		redefine
			make,
			make_with_text,
			has_parent
		end

	EV_TREE_ITEM_HOLDER_IMP
		rename
			parent_set as widget_parent_set,
			add_double_click_command as old_add_dblclk,
			remove_double_click_commands as old_remove_dblclk,
			parent_imp as widget_parent_imp,
			set_parent as widget_set_parent
		undefine
			has_parent
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create an item with an empty name.
		do
			widget := gtk_tree_item_new
			gtk_object_ref (widget)
		end
	
	make_with_text (txt: STRING) is
			-- Create an item with `txt' as label.
		local
			a: ANY
		do
			a := txt.to_c
			widget := gtk_tree_item_new_with_label ($a)
			gtk_object_ref (widget)
		end

feature -- Access

--	parent: EV_TREE_ITEM_HOLDER is
--			-- Parent of the current item.
--		do
--			if parent_imp /= Void then
--				Result ?= parent_imp.interface
--			else
--				Result := Void
--			end
--		end

--	parent_imp: EV_TREE_ITEM_HOLDER_IMP
--			-- Parent implementation

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		local
			par_imp: EV_TREE_IMP
				-- local variable created to get the tree_widget Pointer
				-- which is specific to EV_TREE_IMP and is not in EV_TREE_ITEM_HOLDER_IMP
		do
			par_imp ?= parent_imp
			if (par_imp /= void) then
				-- the parent is a EV_TREE_IMP. Therefore the parent
				-- of the tree item is tree_widget.
				Result := c_gtk_tree_item_is_selected (par_imp.tree_widget, widget)
			else
				-- the parent is not a EV_TREE_IMP but a EV_TREE_ITEM_IMP. Therefore the parent
				-- of the tree item is widget.
				Result := c_gtk_tree_item_is_selected (GTK_TREE_ITEM_SUBTREE(parent_imp.widget), widget)
			end
				
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		do
			Result := c_gtk_tree_item_expanded (widget)
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		do
			Result := (GTK_TREE_ITEM_SUBTREE(widget) /= default_pointer)
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if (flag) then
				gtk_tree_item_select (widget)
			else
				gtk_tree_item_deselect (widget)
			end
		end
	
feature -- Element change

	set_parent (par: EV_TREE_ITEM_HOLDER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_TREE_ITEM_HOLDER_IMP
			parent_temp : EV_TREE_ITEM_HOLDER
		do
			if parent_imp /= Void then
				gtk_object_ref (widget)
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				parent_imp := par_imp


				parent_temp ?= parent_imp.interface

				par_imp.add_item (Current)
				show
				gtk_object_unref (widget)
			end
		end

feature -- Assertion

	has_parent : BOOLEAN is
			-- Redefinition of has_a_parent, already defined
			-- in EV_WIDGET_I, because parent_imp has been
			-- redefined as widget_parent_imp
		do
			Result := parent_imp /= void
		end

feature -- Event : command association

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be
			-- executed when the selection subtree
			-- expanded or collapsed.
		do
			add_command ("expand", cmd, arg)
			add_command ("collapse", cmd, arg)
		end

feature -- Event -- removing command association

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		do
			remove_commands (expand_id)
			remove_commands (collapse_id)
		end

feature {NONE} -- Implementation

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item' to the list
		local
			p: POINTER
		do
			if GTK_TREE_ITEM_SUBTREE(widget) = default_pointer then
				p := gtk_tree_new
				gtk_tree_item_set_subtree (widget, p)
				c_gtk_tree_set_single_selection_mode (GTK_TREE_ITEM_SUBTREE(widget))
			end
			gtk_tree_append (GTK_TREE_ITEM_SUBTREE(widget), item_imp.widget)
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the list.
		do
			gtk_tree_remove_item (GTK_TREE_ITEM_SUBTREE(widget), item_imp.widget)
		end

end -- class EV_TREE_ITEM_IMP

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
