indexing
	description: "EiffelVision multi-column list row, mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I
		select
			parent_imp
		end

	EV_COMPOSED_ITEM_IMP
		rename
			count as columns,
			set_count as set_columns,
			parent_imp as old_parent_imp
		undefine
			parent
		redefine
			destroy,
			set_cell_text
		end

	EV_PND_SOURCE_IMP

creation
	make,
	make_with_text

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current)
		end

feature -- Status report
	
	destroyed: BOOLEAN is
			-- Is Current row destroyed?  
		do
			Result := (internal_text = Void) or else (internal_text.empty)
		end

	is_selected: BOOLEAN is
			-- Is the item selected?
		do
			Result := parent_imp.internal_is_selected (Current)
		end

feature -- Status setting

	destroy is
			-- Destroy the actual object.
		do
			{EV_COMPOSED_ITEM_IMP} Precursor
			internal_text := Void
		end

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
 			if flag then
 				parent_imp.internal_select (Current)
 			else
				parent_imp.internal_deselect (Current)
 			end
		end

feature -- Element Change

	set_cell_text (column: INTEGER; txt: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		do
			{EV_COMPOSED_ITEM_IMP} Precursor (column, txt)
			if parent_imp /= Void then
				parent_imp.set_cell_text (column - 1, index - 1, txt)
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

	add_button_press_command (mouse_button: INTEGER; 
		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is pressed.
		do
			inspect mouse_button 
			when 1 then
				add_command (Cmd_button_one_press, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_press, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_press, cmd, arg)
			end
		end

	add_button_release_command (mouse_button: INTEGER;
		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is released.
		do
			inspect mouse_button
			when 1 then
				add_command (Cmd_button_one_release, cmd, arg)
			when 2 then
				add_command (Cmd_button_two_release, cmd, arg)
			when 3 then
				add_command (Cmd_button_three_release, cmd, arg)
			end
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed
			-- when the item is selected.
		do
			remove_command (Cmd_item_activate)
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed
			-- when the item is unselected.
		do
			remove_command (Cmd_item_deactivate)		
		end

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_press)
			when 2 then
				remove_command (Cmd_button_two_press)
			when 3 then
				remove_command (Cmd_button_three_press)
			end
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		do
			inspect mouse_button 
			when 1 then
				remove_command (Cmd_button_one_release)
			when 2 then
				remove_command (Cmd_button_two_release)
			when 3 then
				remove_command (Cmd_button_three_release)
			end
		end

feature {NONE} -- Implementation

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		do
			Result := parent_imp
		end

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

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
