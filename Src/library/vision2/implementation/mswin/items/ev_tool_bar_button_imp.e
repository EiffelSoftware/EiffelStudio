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

	EV_SIMPLE_ITEM_IMP
		undefine
			pixmap_size_ok
		redefine
			set_text,
			set_pixmap
		end

	EV_ID_IMP

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create the item.
		do
			id := new_id
		end

feature -- Access

	parent_imp: EV_TOOL_BAR_IMP
			-- Parent implementation

	index: INTEGER is
			-- Index of the button in the tool-bar.
		do
			Result := parent_imp.internal_index (id) + 1
		end

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
			Result := not parent_imp.toolbar.button_enabled (id)
		end

feature -- Status setting

	destroy is
			-- Destroy the actual item.
		do
			if parent_imp /= Void then
				parent_imp.remove_button (Current)
				parent_imp := Void
			end
			interface := Void
		end

	set_insensitive (flag: BOOLEAN) is
			-- Make the current button insensitive if `flag' and
			-- enable if `not flag'
		do
			if flag then
				parent_imp.toolbar.disable_button (id)
			else
				parent_imp.toolbar.enable_button (id)
			end
		end

feature -- Element change

	set_parent (par: EV_TOOL_BAR) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		do
			if parent_imp /= Void then
				parent_imp.remove_button (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.add_button (Current)
			end
		end

	set_parent_with_index (par: EV_TOOL_BAR; value: INTEGER) is
			-- Make `par' the new parent of the widget and set
			-- the current button at `value'.
		do
			if parent_imp /= Void then
				parent_imp.remove_button (Current)
				parent_imp := Void
			end
			if par /= Void then
				parent_imp ?= par.implementation
				parent_imp.insert_button (Current, value)
			end
		end

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

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		do
			remove_command (Cmd_item_activate)			
		end	

feature {EV_TOOL_BAR_IMP} -- Implementation

	on_activate is
			-- Is called by the menu when the item is activated.
		do
			execute_command (Cmd_item_activate, Void)
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
