indexing
	description:
		" EiffelVision Toolbar button, mswindows implementation."
	note: " Menu-items have even ids and tool-bar buttons have%
		% odd ids because both use the on_wm_command."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		select
			parent_imp
		end

	EV_SIMPLE_ITEM_IMP
		rename
			parent_imp as old_parent_imp
		undefine
			pixmap_size_ok,
			parent
		redefine
			set_text,
			set_pixmap
		end

	EV_ID_IMP

	EV_PND_SOURCE_IMP

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the item.
		do
			id := new_id
		end

	make_with_text (txt: STRING) is
			-- Create a row with text in it.
		do
			id := new_id
			set_text (txt)
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

	id: INTEGER
			-- Identifier of the item

feature -- Status report

	destroyed: BOOLEAN is
			-- Is current object destroyed ?
			-- Yes if the item doesn't exist in the parent.
		do
			Result := False
		end

	type: INTEGER is
			-- Type of the button.
			-- See `add_button' of EV_TOOL_BAR_IMP for values
			-- explanation.
		do
			Result := 1
		end

	is_insensitive: BOOLEAN is
			-- Is the current button insensitive?
		do
			Result := not parent_imp.button_enabled (id)
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

	set_insensitive (flag: BOOLEAN) is
			-- Make the current button insensitive if `flag' and
			-- enable if `not flag'
		do
			if flag then
				parent_imp.disable_button (id)
			else
				parent_imp.enable_button (id)
			end
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
			end
		end

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
			-- We need to destroy the dc that comes with it,
			-- because a bitmap can be linked to only one dc
			-- at a time.
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (pix)
			if parent_imp /= Void then
				parent_imp.internal_reset_button (Current)
			end
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		do
			add_command (Cmd_item_activate, cmd, arg)			
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
			-- Empty the list of commands to be executed when
			-- the item is selected.
		do
			remove_command (Cmd_item_activate)			
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

feature {EV_INTERNAL_TOOL_BAR_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activated.
		do
			execute_command (Cmd_item_activate, Void)
		end

feature {NONE} -- Implementation, pick and drop

	widget_source: EV_WIDGET_IMP is
			-- Widget drag source used for transport
		do
			Result := parent_imp
		end

end -- class EV_TOOL_BAR_BUTTON_IMP

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
