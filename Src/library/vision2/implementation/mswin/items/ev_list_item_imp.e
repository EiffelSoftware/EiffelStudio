indexing

	description: "EiffelVision list item. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_LIST_ITEM_IMP
	
inherit

	EV_LIST_ITEM_I

	EV_ITEM_IMP
		export {EV_LIST_IMP}
			id,
			set_id
		redefine
			parent_imp
		end

creation

	make, make_with_text

feature {NONE} -- Initialization

	make (par: EV_LIST) is
			-- Add and create an item with an empty label.
		do
			parent_imp ?= par.implementation
			check
				parent_not_void: parent_imp /= Void
			end
			parent_imp.set_name ("")
		end

	make_with_text (par: EV_LIST; txt: STRING) is
			-- Add and create an item with `txt' as label.
		do
			parent_imp ?= par.implementation
			check
				parent_not_void: parent_imp /= Void
			end
			parent_imp.set_name (txt)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := parent_imp.is_selected (id)
		end

	text: STRING is
			-- Current label of the item
		do
			Result := parent_imp.i_th_text (id)
		end

	
	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the parent_imp.
		do
			Result := not parent_imp.ev_children.has (Current)
		end

feature -- Status setting

	destroy is
			-- Destroy the actual item.
		do
			parent_imp.remove_item (id)
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			parent_imp.select_item (id)
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

	set_text (str: STRING) is
			-- Set `text' to `str'.
		do
			parent_imp.delete_string (id)
			parent_imp.insert_string_at (str, id)
		end

feature -- Event : command association

	add_double_click_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add 'command' to the parent_imp of commands to be
			-- executed when the item is double clicked
		do
			add_command (Cmd_item_dblclk, a_command, arguments)
		end	

feature {NONE} -- Access for implementation
	
	parent_imp: EV_LIST_IMP
		-- list that contains the current item.
	
--feature -- Element change -- Implementation

--	set_parent (new_list: EV_LIST_IMP) is
--			-- Set `list' to `new_list'.
--		do
--			list := new_list
--		end

end -- class EV_LIST_ITEM_IMP

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
