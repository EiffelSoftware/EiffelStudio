indexing

	description: 
		"EiffelVision text component, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_IMP
	
inherit
	EV_TEXT_COMPONENT_I
	
	EV_PRIMITIVE_IMP
		undefine
			set_default_options,
			set_default_colors
		end

feature -- Access

	text_length: INTEGER is
			-- Length of the text in the widget
		do
			Result := text.count
		end

feature -- Status report

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := c_gtk_editable_position (widget) + 1
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			Result := c_gtk_editable_has_selection (widget)
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := c_gtk_editable_selection_start (widget)
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := c_gtk_editable_selection_end (widget)
		end

feature -- status settings

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			gtk_editable_set_editable (widget, flag)
		end

	set_position (pos: INTEGER) is
			-- set current insertion position
		do
			gtk_editable_set_position (widget, pos - 1)
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		do
			check not_implemented: False end
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		do
			gtk_editable_select_region (widget, start_pos, end_pos)
		end	

	select_all is
			-- Select all the text.
		do
			gtk_editable_select_region (widget, 0, text_length)
		end

	deselect_all is
			-- Unselect the current selection.
		do
			gtk_editable_select_region (widget, 0, text_length)
		end

	delete_selection is
			-- Delete the current selection.
		do
			gtk_editable_delete_selection (widget)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		do
			gtk_editable_cut_clipboard (widget)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			gtk_editable_copy_clipboard (widget)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		do
			gtk_editable_paste_clipboard (widget)
		end

feature -- Event - command association

	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text of the widget have changed.
		do
			add_command ("changed", cmd, arg)
		end

feature -- Event -- removing command association

	remove_change_commands is
			-- Empty the list of commands to be executed
			-- when the text of the widget have changed.
		do
			remove_commands (changed_id)
		end

end -- class EV_TEXT_COMPONENT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable  components for ISE Eiffel.
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
