indexing
	description: 
		"EiffelVision text component, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_I
	
inherit
	EV_PRIMITIVE_I
		redefine
			set_default_options,
			set_default_colors
		end

feature -- Access

	text: STRING is
			-- Text of current label
		require
			exists: not destroyed
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	text_length: INTEGER is
			-- Length of the text in the widget
		require
			exists: not destroyed
		deferred
		end

	selected_text: STRING is
			-- Text which is currently selected
		require
			exists: not destroyed
		do
			Result := text.substring (selection_start, selection_end)
		end

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		require
			valid_line_index: valid_line_index (i)
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable
		require
			exists: not destroyed
		deferred
		end

	position: INTEGER is
			-- Current position of the caret.
		require
			exist: not destroyed
		deferred
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		require
			exist: not destroyed
		deferred
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		require
			exist: not destroyed
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		require
			exist: not destroyed
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	line_count: INTEGER is
			-- Number of lines in widget
		require
			exist: not destroyed
		deferred
		ensure
			result_greater_zero: Result > 0
		end 

	first_character_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i)
		deferred
		ensure
			valid_character_position: valid_character_position (i)
		end

	last_character_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i)
		deferred
		ensure
			valid_character_position: valid_character_position (i)
		end

	valid_line_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid line index?
		require
			exist: not destroyed
		do
			Result := i > 0 and i < line_count
		end

	valid_character_position (pos: INTEGER): BOOLEAN is
		require
			exist: not destroyed
		do
			Result := pos > 0 and pos < text_length			
		end

feature -- Status setting
	
	set_default_options is
			-- Initialize the options of the widget.
		do
			set_expand (True)
			set_vertical_resize (False)
			set_horizontal_resize (True)
		end

	set_default_colors is
			-- Initialize the colors of the widget
		local
			color: EV_COLOR
		do
			!! color.make_rgb (255, 255, 255)
			set_background_color (color)
			!! color.make_rgb (0, 0, 0)
			set_foreground_color (color)
		end

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		require
			exists: not destroyed
		deferred
		end

	set_position (pos: INTEGER) is
			-- set current insertion position
		require
			exist: not destroyed			
			position_large_enough: pos >= 1
			position_small_enough: pos <= text_length + 1
			is_editable: is_editable
		deferred
		end
	
feature -- Element change

	set_text (txt: STRING) is
			-- set text in component to 'txt'
		require
			exist: not destroyed			
			valid_text: txt /= Void
--			is_editable: is_editable
		deferred
		ensure
			text_set: text.is_equal (txt)
		end

	insert_text (txt: STRING) is
			-- Insert `txt' at the current position.
		require
			exists: not destroyed
			valid_text: txt /= Void
			is_editable: is_editable
		deferred
		end
	
	append_text (txt: STRING) is
			-- append 'txt' into component
		require
			exist: not destroyed			
			valid_text: txt /= Void
			is_editable: is_editable
		deferred
		ensure
			text_appended:
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		require
			exist: not destroyed			
			valid_text: txt /= Void
			is_editable: is_editable
		deferred
		ensure
			text_prepended:
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		require
			exists: not destroyed
			valid_nb: nb > 0
		deferred
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		require
			exist: not destroyed
			valid_start: start_pos >= 1 and start_pos <= text_length
			valid_end: end_pos >= 1 and end_pos <= text_length
		deferred
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = start_pos
			selection_end_set: selection_end = end_pos
		end	

	select_all is
			-- Select all the text.
		require
			exist: not destroyed
			positive_length: text_length > 0
		deferred
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 1
			selection_end_set: selection_end <= text_length + 2
		end

	deselect_all is
			-- Unselect the current selection.
		require
			exist: not destroyed
		deferred
		ensure
			has_no_selection: not has_selection
		end

	delete_selection is
			-- Delete the current selection.
		require
			exist: not destroyed
			has_selection: has_selection
			is_editable: is_editable
		deferred
		ensure
			has_no_selection: not has_selection
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		require
			exists: not destroyed
			has_selection: has_selection
			is_editable: is_editable
		deferred
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		require
			exists: not destroyed
			has_selection: has_selection
		deferred
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		require
			exists: not destroyed
			index_large_enough: index >= 1
			index_small_enough: index <= text_length + 1
			is_editable: is_editable
		deferred
		end

feature -- Event - command association

	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed 
			-- when the text of the widget have changed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_change_commands is
			-- Empty the list of commands to be executed
			-- when the text of the widget have changed.
		require
			exists: not destroyed
		deferred
		end
	
end --class EV_TEXT_COMPONENT_I

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
