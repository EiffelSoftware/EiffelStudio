indexing
	description: 
		"EiffelVision text component. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_I
	
inherit
	EV_PRIMITIVE_I

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_I

feature -- Access

	text: STRING is
			-- `Result' is text of `Current'.
		require
		deferred
		end

	text_length: INTEGER is
			-- Length of the text in `Current'.
		require
		deferred
		end

	selected_text: STRING is
			-- Text currently selected in `Current'.
		require
		do
			Result := text.substring (selection_start, selection_end)
		end

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		deferred
		end

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		deferred
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable by the user?
		require
		deferred
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		require
		deferred
		end

	has_selection: BOOLEAN is
			-- Does `Current' have a selection?
		require
		deferred
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		require
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		require
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	valid_caret_position (pos: INTEGER): BOOLEAN is
			-- Is `pos' a valid position for the caret?
		require
		do
			Result := pos >= 1 and pos <= text_length + 1			
		end

feature -- Status setting
	
	set_editable (flag: BOOLEAN) is
			-- if `flag' then make the component read-write.
			-- if not `flag' then make the component read-only.
		require
		deferred
		end

	set_caret_position (pos: INTEGER) is
			-- set current insertion position
		require
			position_large_enough: pos >= 1
			position_small_enough: pos <= text_length + 1
			is_editable: is_editable
		deferred
		end
	
feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to text of `Current'.
		deferred
		ensure
			text_set: text.is_equal (a_text)
		end

	remove_text is
			-- Make `text' `Void'.
		do
			set_text (Void)
		ensure
			text_empty: text.is_empty
		end

	insert_text (txt: STRING) is
			-- Insert `txt' at the current caret position.
		require
			valid_text: txt /= Void
		deferred
		end
	
	append_text (txt: STRING) is
			-- append 'txt' into `Current'.
		require
			valid_text: txt /= Void
		deferred
		ensure
			text_appended:
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' into `Current'.
		require
			valid_text: txt /= Void
		deferred
		ensure
			text_prepended:
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make a minimum of `nb' of the widest character visible
			-- on one line.
		require
			valid_nb: nb > 0
		deferred
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		require
			valid_start: start_pos >= 1 and start_pos <= text_length
			valid_end: end_pos >= 1 and end_pos <= text_length
		deferred
		ensure
			has_selection: (start_pos /= end_pos) implies has_selection
			selection_start_set: selection_start = start_pos
			selection_end_set: selection_end = end_pos
		end	

	select_all is
			-- Select all the text of `Current'.
		require
			positive_length: text_length > 0
		do
			select_region (1, text.count)
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 1
			selection_end_set: selection_end = text_length
		end

	deselect_all is
			-- Unselect the current selection.
		require
		deferred
		ensure
			has_no_selection: not has_selection
		end

	delete_selection is
			-- Delete the current selection.
		require
			has_selection: has_selection
			is_editable: is_editable
		deferred
		ensure
			has_no_selection: not has_selection
		end

	cut_selection is
			-- Cut `selected_region' by erasing it from
			-- the text and putting it in the Clipboard to paste it later.
			-- If `selectd_region' is empty, it does nothing.
		require
			has_selection: has_selection
			is_editable: is_editable
		deferred
		end

	copy_selection is
			-- Copy `selected_region' into the Clipboard.
			-- If the `selected_region' is empty, it does nothing.
		require
			has_selection: has_selection
		deferred
		end

	paste (index: INTEGER) is
			-- Insert the contents of the clipboard 
			-- at `index' postion of `text'.
			-- If the Clipboard is empty, it does nothing. 
		require
			index_large_enough: index >= 1
			index_small_enough: index <= text_length + 1
			is_editable: is_editable
		deferred
		end

end -- class EV_TEXT_COMPONENT_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

