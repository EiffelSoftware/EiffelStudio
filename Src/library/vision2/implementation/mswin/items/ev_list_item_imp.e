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
		select
			parent_imp
		end

	EV_SIMPLE_ITEM_IMP
		rename
			parent_imp as old_parent_imp
		undefine
			parent
		redefine
			set_text
		end

	EV_SYSTEM_PEN_IMP
		export
			{NONE} all
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the widget with `par' as parent.
		do
			set_text ("")
		end

	make_with_text (txt: STRING) is
			-- Create a row with text in it.
		do
			set_text (txt)
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the parent.
		do
			Result := False
		end

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := parent_imp.internal_is_selected (Current)
		end

	is_first: BOOLEAN is
			-- Is the item first in the list ?
		do
			Result := (index = 1)
		end

	is_last: BOOLEAN is
			-- Is the item last in the list ?
		do
			Result := (index = parent_imp.count)
		end
	
feature -- Status setting

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if parent_imp /= Void then
				parent_imp.remove_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.add_item (Current)
			end
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				parent_imp.internal_select_item (Current)
			else
				parent_imp.internal_deselect_item (Current)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)
			if parent_imp /= Void then
				parent_imp.internal_set_text (Current, txt)
			end
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		do
			add_command (Cmd_item_activate, cmd, arg)			
		end	

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		do
			add_command (Cmd_item_deactivate, cmd, arg)		
		end

	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed
			-- when the item is double clicked.
		do
			add_command (Cmd_item_dblclk, cmd, arg)
		end	

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		do
			remove_command (Cmd_item_activate)			
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		do
			remove_command (Cmd_item_deactivate)		
		end

	remove_double_click_commands is
			-- Empty the list of commands to be executed when
			-- the item is double-clicked.
		do
			remove_command (Cmd_item_dblclk)
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
