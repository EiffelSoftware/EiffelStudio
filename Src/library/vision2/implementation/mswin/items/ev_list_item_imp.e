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
			set_id,
			command,
			arguments
		end

creation

	make, make_with_text

feature {NONE} -- Initialization

	make (par: EV_LIST) is
			-- Add and create an item with an empty label.
		local
			par_imp: EV_LIST_IMP
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			list := par_imp
			par_imp.set_name ("")
		end

	make_with_text (par: EV_LIST; txt: STRING) is
			-- Add and create an item with `txt' as label.
		local
			par_imp: EV_LIST_IMP
		do
			par_imp ?= par.implementation
			check
				parent_not_void: par_imp /= Void
			end
			list := par_imp
			par_imp.set_name (txt)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := list.wel_window.is_selected (id)
		end

feature -- Status setting

	destroy is
			-- Destroy the actual item.
		do
			list.remove_item (id)
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			list.wel_window.select_item (id)
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

feature -- Status report -- Implementation

	text: STRING is
			-- Current label of the menu item
		do
			Result := list.wel_window.i_th_text (id)
		end

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the list.
		do
			Result := not list.children.has (Current)
		end

feature -- Event : command association

	add_double_click_command (a_command: EV_COMMAND; 
			       arg: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the item is double clicked
		do
			dc_command := a_command
			dc_arguments := arg
	end	

feature {EV_LIST_IMP} -- Access for implementation

	dc_command: EV_COMMAND
		-- Command that must be called when the item is selected
		-- by a double click of the left button of the mouse.

	dc_arguments: EV_ARGUMENTS
		-- Argument that goes with the `dc_command'

feature {NONE} -- Access for implementation
	
	list: EV_LIST_IMP
		-- list that contains the current item.
	
feature -- Element change -- Implementation

	set_text (str: STRING) is
			-- Set `text' to `str'.
		do
			list.wel_window.delete_string (id)
			list.wel_window.insert_string_at (str, id)
		end

	set_parent (new_list: EV_LIST_IMP) is
			-- Set `list' to `new_list'.
		do
			list := new_list
		end

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
