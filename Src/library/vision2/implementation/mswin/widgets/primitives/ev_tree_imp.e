indexing
	description: 
		"EiffelVision tree, Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I

	EV_PRIMITIVE_IMP

	EV_TREE_ITEM_CONTAINER_IMP

	WEL_TREE_VIEW
		rename
			make as wel_make,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			font as wel_font,
			set_font as wel_set_font
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
			on_char,
			on_key_down,
			on_key_up
		redefine
			on_tvn_selchanged,
			on_tvn_itemexpanded
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a new tree with `par' as parent.
		local
			par_imp: WEL_WINDOW
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			wel_make (par_imp, 0, 0, 0, 0, 0)
			!! ev_children.make (1)
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		do
			add_command (Cmd_selection, cmd, arg)
		end

feature {EV_TREE_ITEM_CONTAINER_IMP} -- Implementation attributes

	ev_children: HASH_TABLE [EV_TREE_ITEM_IMP, INTEGER]
			-- Children of the tree Classified by their h_item

feature {NONE} -- Implementation

	add_item (an_item: EV_TREE_ITEM) is
			-- Add `item' to the list
		local
			item_imp: EV_TREE_ITEM_IMP
			insert_struct: WEL_TREE_VIEW_INSERT_STRUCT
		do
			item_imp ?= an_item.implementation
			check
				valid_item: item_imp /= Void
			end
			!! insert_struct.make
			insert_struct.set_root
			insert_struct.set_tree_view_item (item_imp)
			insert_item (insert_struct)
			item_imp.set_h_item (last_item)
			ev_children.extend (item_imp, last_item)
		end

feature {NONE} -- WEL Implementation

	on_tvn_selchanged (info: WEL_NM_TREE_VIEW) is
			-- Selection has changed from one item to another.
		local
			clist: HASH_TABLE [EV_TREE_ITEM_IMP, INTEGER]
		do
			clist := ev_children
			if clist @ info.old_item.h_item /= Void then
				(clist @ info.old_item.h_item).execute_command (Cmd_item_deactivate, Void)
			end
			if clist @ info.new_item.h_item /= Void then
				(clist @ info.new_item.h_item).execute_command (Cmd_item_activate, Void)
			end
			execute_command (Cmd_selection, Void)
		end

	on_tvn_itemexpanded (info: WEL_NM_TREE_VIEW) is
			-- a parent item's list of child items has expanded
			-- or collapsed.
		do
			if info.action = Tve_collapse or
				info.action = Tve_expand then
				(ev_children @ info.new_item.h_item).execute_command (Cmd_item_subtree, Void)
			end
		end

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
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

end -- class EV_TREE_IMP

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
